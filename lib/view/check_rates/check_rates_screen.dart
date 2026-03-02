import 'package:ev/controller/service_controller.dart';
import 'package:ev/utils/currency_formatter.dart';
import 'package:ev/view/order_package_details/widgets/service_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckRatesScreen extends StatefulWidget {
  const CheckRatesScreen({super.key});

  @override
  State<CheckRatesScreen> createState() => _CheckRatesScreenState();
}

class _CheckRatesScreenState extends State<CheckRatesScreen> {
  late final ServiceController serviceController;

  @override
  void initState() {
    super.initState();
    serviceController = Get.put(ServiceController());
    serviceController.fetchAllServices();
  }

  // String _formatPrice(double? value) {
  //   final amount = value ?? 0.0;
  //   final numberFormat = NumberFormat.currency(
  //     locale: 'en_IN',
  //     symbol: '₹',
  //     decimalDigits: amount % 1 == 0 ? 0 : 2,
  //   );
  //   return numberFormat.format(amount);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Check Rates")),
      body: Obx(() {
        final services = serviceController.services;

        if (services.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: services.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final service = services[index];
            String price = CurrencyFormatter.format(service.totalAmount);
            return ServiceTile(
              // title: service.serviceName,
              // notes: service.notes,
              // price: _formatPrice(service.totalPrice),
              title: service.vehicleType ?? "Unknown Service",
              notes: service.vehicleLoadCapacity ?? "No Capacity Info",
              price: price,

              // price:
              //     '₹ ${(service.serviceAmount + service.extraCharges).toStringAsFixed(2)}',
              onTap: () {},
            );
          },
        );
      }),
    );
  }
}
