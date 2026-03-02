// ignore_for_file: avoid_print, deprecated_member_use

import 'package:ev/common/body_title.dart';
import 'package:ev/common/button.dart';
import 'package:ev/common/toast_message.dart';
import 'package:ev/controller/order_details_controller.dart';
import 'package:ev/controller/order_location_controller.dart';
import 'package:ev/controller/service_controller.dart';
import 'package:ev/helper/model/service_model.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/view/location_map/location_pick_from_map.dart';
import 'package:ev/view/order_package_details/widgets/order_package_details_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateOrderLocationEntryScreen extends StatefulWidget {
  const CreateOrderLocationEntryScreen({super.key});

  @override
  State<CreateOrderLocationEntryScreen> createState() =>
      _CreateOrderLocationEntryScreenState();
}

class _CreateOrderLocationEntryScreenState
    extends State<CreateOrderLocationEntryScreen> {
  final locationController = Get.put(OrderLocationController());
  final orderDetailsController = Get.put(OrderDetailsController());
  final pickupTextController = TextEditingController();
  final deliveryTextController = TextEditingController();
  final goodsTypeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ServiceModel? selectedService;



Future<bool> _showExitConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false, // User must tap a button
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Discard Order?'),
            content: const Text(
              'Are you sure you want to leave? All entered information will be lost.',
               style: TextStyle( fontWeight: FontWeight.w500, fontSize: 15)
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false); // Don't exit
                },
              ),
              ElevatedButton(
                child: const Text('Yes, Exit'),
                onPressed: () {
                    orderDetailsController.clearAllOrderDetails(); // 🧹 clear everything
                  Navigator.of(context).pop(true); // Exit screen
                },
              ),
            ],
          );
        },
      ) ??
      false; // Return false if dialog dismissed
}

  @override
  void initState() {
    super.initState();

    // Listen to controller and update text fields
    ever(locationController.pickupAddress, (_) {
      pickupTextController.text = locationController.pickupAddress.value;
    });
    ever(locationController.deliveryAddress, (_) {
      deliveryTextController.text = locationController.deliveryAddress.value;
    });

    Get.put(ServiceController()).fetchAllServices();
  }


  bool _hasUnsavedData() {
  return pickupTextController.text.isNotEmpty ||
      deliveryTextController.text.isNotEmpty ||
      goodsTypeController.text.isNotEmpty ||
      selectedService != null; // user selected a service
}


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      if (_hasUnsavedData()) {
        // Show confirmation dialog ONLY if data exists
        return await _showExitConfirmationDialog(context);
      }
      return true; // no data → allow normal back navigation
    },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Create Order')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBodyTitle(title: "Location Details"),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.radio_button_checked,
                        size: 28,
                        color: Colors.green,
                      ),
                      ...List.generate(
                        7,
                        (_) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: SizedBox(
                            height: 4,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        Iconsax.location,
                        size: 28,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        Material(
                          color: Colors.grey.shade50,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            //  side: BorderSide(color: TColors.primary),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap:
                                () => Get.to(
                                  () => SelectOrderLocationMapScreen(
                                    isPickup: true,
                                  ),
                                ),
                            child: AbsorbPointer(
                              child: TextFormField(
                                 style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                controller: pickupTextController,
                                decoration: InputDecoration(
                                  hintText: 'Order Pickup Location',
                                  suffixIcon: const Icon(Iconsax.gps),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
      
                        const SizedBox(height: 24),
                        Material(
                          color: Colors.grey.shade50,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            //  side: BorderSide(color: TColors.primary),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap:
                                () => Get.to(
                                  () => SelectOrderLocationMapScreen(
                                    isPickup: false,
                                  ),
                                ),
                            child: AbsorbPointer(
                              child: TextFormField(
                                 style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                controller: deliveryTextController,
                                decoration: InputDecoration(
                                  hintText: 'Order Delivery Location',
                                  suffixIcon: const Icon(Iconsax.gps),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              TBodyTitle(title: "Package Details"),
              SizedBox(height: 16),
      
              //OrderPackageDetailsForm(),
              OrderPackageDetailsForm(
                goodsController: goodsTypeController,
                onServiceSelected: (service) {
                  selectedService = service; // ✅ Save in local variable
                  // ✅ Update controller here
                  orderDetailsController.selectedService.value =
                      selectedService?.vehicleType ?? '';
      
                  // orderDetailsController.selectedService.value =
                  //     service.serviceName;
                  print('🔹 Selected service: ${service.vehicleType}');
                },
                formKey: _formKey,
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: TNavigationButton(
              buttonTitle: "Continue",
              onTap: () {
                // Check if pickup and delivery locations are selected
                if (pickupTextController.text.isEmpty ||
                    deliveryTextController.text.isEmpty) {
                  ToastMessage.show(
                    "Missing Information. Please select both pickup and delivery locations.",
                    isSuccess: false,
                  );
                  // CustomSnackbar.showSnack(
                  //   "Missing Information",
                  //   "Please select both pickup and delivery locations.",
                  //   false,
                  // );
                  return;
                }
      
                // Validate form
                if (_formKey.currentState!.validate()) {
                  orderDetailsController.pickupAddress.value =
                      pickupTextController.text;
                  orderDetailsController.deliveryAddress.value =
                      deliveryTextController.text;
      
                  final pickupLatLng = locationController.pickupLocation.value;
      
                  if (pickupLatLng != null) {
                    orderDetailsController.pickupLatitude.value =
                        pickupLatLng.latitude.toString();
                    orderDetailsController.pickupLongitude.value =
                        pickupLatLng.longitude.toString();
                  }
      
                  // orderDetailsController.selectedService.value =
                  //     selectedService?.serviceName ?? '';
      
                  orderDetailsController.selectedService.value =
                      selectedService?.vehicleType ?? '';
      
                  orderDetailsController.goodsType.value =
                      goodsTypeController.text;
      
                  orderDetailsController.saveToPrefs(); // optional
      
                  Get.toNamed(AppRoutes.receiverInfo);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
