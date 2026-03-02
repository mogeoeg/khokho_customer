// import 'dart:math';
// import 'package:ev/controller/coupon_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ev/utils/colors.dart';

// class TCouponContainer extends StatefulWidget {
//   const TCouponContainer({super.key});

//   @override
//   State<TCouponContainer> createState() => _TCouponContainerState();
// }

// class _TCouponContainerState extends State<TCouponContainer> {
//   @override
//   void initState() {
//     super.initState();
//     Get.put(CouponController()).fetchCoupons();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CouponController>();

//     final random = Random();
//     final colors = [
//       Colors.pink.shade100,
//       Colors.green.shade100,
//       Colors.orange.shade100,
//       Colors.blue.shade100,
//       Colors.purple.shade100,
//       Colors.yellow.shade100,
//       Colors.teal.shade100,
//     ];

//     return Scaffold(
//       appBar: AppBar(title: const Text("Coupons")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.coupons.isEmpty) {
//           return const Center(child: Text("No coupons available."));
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: controller.coupons.length,
//           itemBuilder: (context, index) {
//             final coupon = controller.coupons[index];
//             final color = colors[random.nextInt(colors.length)];

//             return Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 160,
//                     decoration: BoxDecoration(
//                       color: color,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(12),
//                         bottomLeft: Radius.circular(12),
//                       ),
//                     ),
//                     child: const Center(
//                       child: RotatedBox(
//                         quarterTurns: 3,
//                         child: Text(
//                           "OFFER",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black54,
//                             fontSize: 14,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 8,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Text("🎁", style: TextStyle(fontSize: 18)),
//                               const SizedBox(width: 6),
//                               Text(
//                                 coupon.coupenName,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             coupon.notes ?? 'Redeem your Coupon',
//                             maxLines: 4,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             "Code: ${coupon.coupenCode}",
//                             style: const TextStyle(
//                               fontSize: 13,
//                               color: Colors.orange,
//                               fontWeight: FontWeight.w700,
//                               letterSpacing: 1.1,
//                             ),
//                           ),
//                           // const SizedBox(height: 8),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               if (coupon.couponAmount != null)
//                                 Text(
//                                   "Discount: ₹${coupon.couponAmount}",
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black87,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 )
//                               else
//                                 const SizedBox(
//                                   width: 1,
//                                 ), // Invisible placeholder to keep spacing

//                               TextButton(
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: Colors.white,
//                                   backgroundColor: TColors.primary,
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 14,
//                                     vertical: 8,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   controller.applyCoupon(
//                                     coupon,
//                                   ); // ✅ set selected coupon
//                                   Get.back(); // Go back to the booking screen
//                                 },

//                                 child: const Text(
//                                   "Redeem Now",
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }




import 'dart:math';
import 'package:ev/controller/coupon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ev/utils/colors.dart';

class TCouponContainer extends StatefulWidget {
  const TCouponContainer({super.key});

  @override
  State<TCouponContainer> createState() => _TCouponContainerState();
}

class _TCouponContainerState extends State<TCouponContainer> {
  late final CouponController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CouponController());
    controller.fetchCoupons();
  }

  Future<void> _refreshCoupons() async {
    await controller.fetchCoupons();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final colors = [
      Colors.pink.shade100,
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.blue.shade100,
      Colors.purple.shade100,
      Colors.yellow.shade100,
      Colors.teal.shade100,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Coupons")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.coupons.isEmpty) {
          return RefreshIndicator(
            onRefresh: _refreshCoupons,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 250),
                Center(child: Text("No coupons available.")),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _refreshCoupons,
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.coupons.length,
            itemBuilder: (context, index) {
              final coupon = controller.coupons[index];
              final color = colors[random.nextInt(colors.length)];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Row(
                  children: [
                    // Left color bar
                    Container(
                      width: 60,
                      height: 140,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            "OFFER",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 14,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Coupon details
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("🎁", style: TextStyle(fontSize: 18)),
                                const SizedBox(width: 6),
                                Text(
                                  coupon.coupenName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              coupon.notes ?? 'Redeem your Coupon',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Code: ${coupon.coupenCode}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.orange,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (coupon.couponAmount != null)
                                  Text(
                                    "Discount: ₹${coupon.couponAmount}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                else
                                  const SizedBox(width: 1),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: TColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.applyCoupon(coupon);
                                    Get.back(); // Go back to booking screen
                                  },
                                  child: const Text(
                                    "Redeem Now",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

