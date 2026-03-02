// ignore_for_file: deprecated_member_use, avoid_print

import 'package:ev/common/button.dart';
import 'package:ev/controller/create_order_controller.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/view/order_booking/case_0.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../controller/order_details_controller.dart'; // Make sure this is the correct path

class BookingOrderScreen extends StatefulWidget {
  const BookingOrderScreen({super.key});

  @override
  State<BookingOrderScreen> createState() => _BookingOrderScreenState();
}

class _BookingOrderScreenState extends State<BookingOrderScreen> {
  // bool isSubmitting = false;
  int currentStep = 0;
  LatLng? pickupLatLng;
  LatLng? dropLatLng;
  double? distanceKm;

  final orderController = Get.find<OrderDetailsController>();
  final createOrderController = Get.put(CreateOrderController());

  @override
  void initState() {
    super.initState();
    resolveLocations();
    // Get.find<CouponController>().fetchCoupons();
  }

  Future<void> resolveLocations() async {
    try {
      final pickupList = await locationFromAddress(
        orderController.pickupAddress.value,
      );
      if (pickupList.isEmpty) {
        print("❌ Pickup location resolution failed");
        return;
      }
      pickupLatLng = LatLng(
        pickupList.first.latitude,
        pickupList.first.longitude,
      );

      final dropPlacemark = await locationFromAddress(
        orderController.deliveryAddress.value,
      );

      // pickupLatLng = LatLng(
      //   pickupPlacemark.first.latitude,
      //   pickupPlacemark.first.longitude,
      // );

      dropLatLng = LatLng(
        dropPlacemark.first.latitude,
        dropPlacemark.first.longitude,
      );
      if (pickupLatLng != null && dropLatLng != null) {
        final distance = Geolocator.distanceBetween(
          pickupLatLng!.latitude,
          pickupLatLng!.longitude,
          dropLatLng!.latitude,
          dropLatLng!.longitude,
        );

        setState(() {
          distanceKm = distance / 1000;
        });
      } else {
        print("❌ Cannot calculate distance, location(s) null");
      }
    } catch (e) {
      print("❌ Error resolving address to location: $e");
    }
  }

  void onBackPressed() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Get.back(); // exit screen
    }
  }

  void onNextPressed() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    }
  }

  Widget getStepContent() {
    switch (currentStep) {
      case 0:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TBookingDropDownDrawer(distanceKm: distanceKm),
            SizedBox(height: 12),
            TNavigationButton(
              buttonTitle: "Make Payment",

              onTap: () async {
                Get.toNamed(
                  AppRoutes.paymentMethod,
                  arguments: {
                    'pickupLatLng': pickupLatLng,
                    'distanceKm': distanceKm,
                  },
                );
              },
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget buildMap() {
    if (pickupLatLng == null || dropLatLng == null) {
      return const Center(child: Text("📍 Location not available"));
    }

    return FlutterMap(
      options: MapOptions(initialCenter: pickupLatLng!, initialZoom: 13),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          //subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.example.ev',
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: [pickupLatLng!, dropLatLng!],
              color: Colors.blue,
              strokeWidth: 6,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: pickupLatLng!,
              width: 60,
              height: 60,
              child: const Icon(
                Icons.location_on,
                color: Colors.green,
                size: 40,
              ),
            ),
            Marker(
              point: dropLatLng!,
              width: 60,
              height: 60,
              child: const Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onBackPressed();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Interactive Map
            SizedBox.expand(child: buildMap()),

            // AppBar Area
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10),
                    ],
                    borderRadius: BorderRadius.circular(34),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: onBackPressed,
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),

            // Bottom Sheet Content
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: SafeArea(
                  bottom: true,
                  top: false,
                  child: getStepContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
