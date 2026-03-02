// ignore_for_file: deprecated_member_use

import 'package:ev/common/body_title.dart';
import 'package:ev/controller/coupon_controller.dart';
import 'package:ev/controller/order_details_controller.dart';
import 'package:ev/controller/service_controller.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/utils/colors.dart';
import 'package:ev/utils/image.strings.dart';
import 'package:ev/view/order_booking/widgets/0_twidget_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBookingDropDownDrawer extends StatelessWidget {
  final double? distanceKm;
  const TBookingDropDownDrawer({super.key, this.distanceKm});

  @override
  Widget build(BuildContext context) {
    final couponController = Get.put(CouponController());
    final serviceController = Get.find<ServiceController>();
    final orderDetailsController = Get.put(OrderDetailsController());

    // fetch controller

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag Handle
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 16),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Side Icons (Pickup -> Drop)
                    Column(
                      children: [
                        Icon(
                          Icons.radio_button_checked,
                          size: 20,
                          color: Colors.green,
                        ),
                        Container(
                          height: 18,
                          width: 2,
                          color: Colors.grey.shade400,
                        ),
                        Icon(Icons.location_on, size: 20, color: Colors.red),
                      ],
                    ),
                    const SizedBox(width: 8),

                    // Location Texts
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pickup Address
                          Text(
                            orderDetailsController
                                    .pickupAddress
                                    .value
                                    .isNotEmpty
                                ? orderDetailsController.pickupAddress.value
                                : "Pickup Location",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                              maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 15),

                          // Delivery Address
                          Text(
                            orderDetailsController
                                    .deliveryAddress
                                    .value
                                    .isNotEmpty
                                ? orderDetailsController.deliveryAddress.value
                                : "Delivery Location",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),

            // // Optional: Distance Row (if available)
            // if (distanceKm != null)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 2, left: 2),
            //     child: Row(
            //       children: [
            //         Icon(Icons.route, size: 18, color: TColors.primary),
            //         SizedBox(width: 8),
            //         Text(
            //           '(${distanceKm!.toStringAsFixed(2)} Km)',
            //           style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600, color: Colors.green[600]),
            //         ),
            //       ],
            //     ),
            //   ),

            // Estimated Time
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(
            //       'Estimated Distance',
            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            //     ),
            //     Row(
            //       children: [
            //         Icon(Icons.route, size: 18, color: TColors.primary),
            //         SizedBox(width: 4),
            //         Text(
            //           distanceKm != null
            //               ? '${distanceKm!.toStringAsFixed(2)} Km'
            //               : '--',
            //           style: TextStyle(fontSize: 14, color: Colors.black87),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            //const SizedBox(height: 12),

            // Coupon field
            Obx(() {
              final selected = couponController.selectedCoupon.value;

              return Material(
                color: Colors.grey.shade50,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  //  side: BorderSide(color: TColors.primary),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Get.toNamed(AppRoutes.coupon),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: TColors.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 36,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(TImages.coupon1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text('Coupon Code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Text(
                          selected != null ? selected.coupenCode : 'Add Coupon',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                selected != null
                                    ? TColors.primary
                                    : Colors.grey, // ✅ conditional color
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),

            // Service Details
            TWidgetRow(title: 'Service', subTitle: 'Medium'),

            const SizedBox(height: 8),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 8),
            TBodyTitle(title: "Payment Summary"),
            const SizedBox(height: 10),

            Obx(() {
              final selected = couponController.selectedCoupon.value;
              final couponAmount = selected?.couponAmount ?? 0;

              final baseFare =
                  serviceController.selectedService.value?.totalAmount ?? 0;

              final grandTotal = baseFare - couponAmount;

              return Column(
                children: [
                  TWidgetRow(
                    title: 'Trip Fare',
                    subTitle: '₹ $baseFare',
                    isTotal: false,
                  
                  ),
                  const SizedBox(height: 6),
                  if (couponAmount > 0)
                    TWidgetRow(
                      title: 'Coupon Amount',
                      subTitle: '- ₹ $couponAmount',
                      isTotal: false,
                    
                    ),
                  const SizedBox(height: 6),
                  TWidgetRow(
                    title: 'Total',
                    subTitle: '₹ $grandTotal',
                    isTotal: true,
                   
                  ),
                ],
              );
            }),

            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}
