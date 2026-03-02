// ✅ UI FILE: Updated showServiceSelectionBottomSheet
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:ev/controller/service_controller.dart';
import 'package:ev/helper/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'service_tile_widget.dart';
import 'package:ev/utils/currency_formatter.dart';

void showServiceSelectionBottomSheet(
  BuildContext context,
  Function(ServiceModel) onSelected,
) {
  final serviceController = Get.put(ServiceController());
  // Add this if not already

  // String _formatPrice(double? value) {
  //   final amount = value ?? 0.0;
  //   final numberFormat = NumberFormat.currency(
  //     locale: 'en_IN',
  //     symbol: '₹',
  //     decimalDigits: amount % 1 == 0 ? 0 : 2,
  //   );
  //   return numberFormat.format(amount);
  // }

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true, // Allow full-height scroll if needed
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Obx(() {
        if (serviceController.isLoading.value) {
          return const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Services',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 14),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: serviceController.services.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final service = serviceController.services[index];
                       String price = CurrencyFormatter.format(service.totalAmount);
                      return ServiceTile(
                        title: service.vehicleType ?? "Unknown Service",
                        notes:
                            service.vehicleLoadCapacity ?? "No Capacity Info",
                        price: price,
                        onTap: () {
                          serviceController.setSelectedService(service);
                          onSelected(service);
                          Navigator.pop(context);
                        },
                        //   title: service.serviceName,
                        //   notes: service.notes,
                        //  // price: '₹ ${service.totalPrice.toStringAsFixed(2)}',
                        //  price: _formatPrice(service.totalPrice),

                        //   onTap: () {
                        //     serviceController.setSelectedService(
                        //       service,
                        //     ); // ✅ Set the selected service
                        //     onSelected(service);
                        //     Navigator.pop(context);
                        //   },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
