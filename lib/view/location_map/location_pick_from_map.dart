// ignore_for_file: control_flow_in_finally

import 'package:ev/common/button.dart';
import 'package:ev/common/toast_message.dart';
import 'package:ev/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../controller/order_location_controller.dart';

class SelectOrderLocationMapScreen extends StatefulWidget {
  final bool isPickup;

  const SelectOrderLocationMapScreen({super.key, required this.isPickup});

  @override
  State<SelectOrderLocationMapScreen> createState() =>
      _SelectOrderLocationMapScreenState();
}

class _SelectOrderLocationMapScreenState
    extends State<SelectOrderLocationMapScreen> {
  final controller = Get.find<OrderLocationController>();

  final mapController = MapController();
  final searchController = TextEditingController();

  LatLng? selected;
  String? address;
  bool isLoading = false;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    selected = LatLng(12.9716, 77.5946); // Default to Bengaluru
    Future.delayed(Duration.zero, () => _updateAddress(selected!));
  }

  Future<void> _updateAddress(LatLng latLng) async {
    if (!mounted) return;
    setState(() => isLoading = true);
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      final place = placemarks.first;
      address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}";
    } catch (_) {
      address = "Unknown address";
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  void _onTap(LatLng latLng) {
    if (selected == latLng) return;
    setState(() => selected = latLng);
    _updateAddress(latLng);
  }

  Future<void> _searchLocation(String query) async {
    if (query.trim().isEmpty) return;
    if (!mounted) return;
    setState(() => isSearching = true);
    try {
      final locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final latLng = LatLng(loc.latitude, loc.longitude);
        if (!mounted) return;
        setState(() => selected = latLng);
        mapController.move(latLng, 15);
        await _updateAddress(latLng);
      } else {
         ToastMessage.show("Location not found,Try a different place.", isSuccess: false);
        
      }
    } catch (e) {
      ToastMessage.show("Failed to find location.", isSuccess: false);
      
    } finally {
      if (!mounted) return;
      setState(() => isSearching = false);
    }
  }

  void _confirm() {
    if (selected == null || address == null) return;

    if (widget.isPickup) {
      controller.setPickup(selected!, address!);
    } else {
      controller.setDelivery(selected!, address!);
    }
    Get.back();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isPickup
              ? "Select Pickup Location"
              : "Select Delivery Location",
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: selected!,
              initialZoom: 13,
              onTap: (tapPos, latlng) => _onTap(latlng),
              interactionOptions: const InteractionOptions(
                flags:
                    InteractiveFlag.all, // 👈 Enables pan, zoom, rotate, etc.
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.ev',
              ),
              if (selected != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selected!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // 🔍 Search Bar
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Material(
              elevation: 3,
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: searchController,
                onSubmitted: _searchLocation,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search a location...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon:
                      isSearching
                          ? Padding(
                            padding: const EdgeInsets.all(12),
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                          : IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            // onPressed: () => searchController.clear(),
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                address = null;
                              });
                            },
                          ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: TColors.primary),
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),

          // 📍 Address Box
          Positioned(
            bottom: 10,
            left: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Text(
                        address ?? "No address",
                        textAlign: TextAlign.center,
                      ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TNavigationButton(
            buttonTitle:
                "Confirm ${widget.isPickup ? 'Pickup' : 'Delivery'} Location",
            isDisabled: selected == null || address == null,
            onTap: _confirm,
          ),
        ),
      ),
    );
  }
}
