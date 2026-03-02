import 'package:ev/common/button.dart';
import 'package:ev/controller/create_order_controller.dart';
import 'package:ev/controller/payment_method_controller.dart';
import 'package:ev/utils/image.strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final controller = Get.put(PaymentMethodController());
  final createOrderController = Get.find<CreateOrderController>();

  late LatLng pickupLatLng;
  late double distanceKm;

  final List<Map<String, String>> paymentMethods = [
    {
      'name': 'Credit / Debit Card',
      'number': '6984 5201 4561 ****',
      'logo': TImages.creditcard, // Replace with actual path
    },

    {
      'name': 'UPI / BHIM',
      'number': 'you@upi',
      'logo': TImages.gpay, // Optional
    },
    {
      'name': 'Cash on Delivery',
      'number': 'ICICI Bank',
      'logo': TImages.cashOnDelivery, // Optional
    },
  ];

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    pickupLatLng = args['pickupLatLng'];
    distanceKm = args['distanceKm'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Method")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: paymentMethods.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final method = paymentMethods[index];

          return Obx(() {
            final isSelected = controller.selectedMethodId.value == index;

            return Material(
              color: Colors.grey.shade50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                //  side: BorderSide(color: TColors.primary),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => controller.setPaymentMethod(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.green : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        method['logo']!,
                        width: 40,
                        height: 40,
                        errorBuilder: (_, _, ___) => const Icon(Iconsax.card),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              method['number']!,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Obx(
            () => TNavigationButton(
              buttonTitle:
                  createOrderController.isSubmitting.value
                      ? "Processing..."
                      : "Confirm Payment",
              onTap: () async {
                if (createOrderController.isSubmitting.value) return;

                await createOrderController.handleSubmitOrder(
                  distanceKm: distanceKm,
                  pickupLatLng: pickupLatLng,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
