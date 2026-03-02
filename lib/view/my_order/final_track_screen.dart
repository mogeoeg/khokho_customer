// ignore_for_file: deprecated_member_use, avoid_print

import 'package:ev/common/button.dart';
import 'package:ev/common/toast_message.dart';
import 'package:ev/controller/cancel_order_controller.dart';
import 'package:ev/controller/payment_method_controller.dart';
import 'package:ev/helper/model/fetch_order_model.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/utils/currency_formatter.dart';
import 'package:ev/utils/image.strings.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FetchOrderModel? order = Get.arguments;
    final CancelOrderController orderController = Get.put(
      CancelOrderController(),
    );

    Map<String, dynamic> getPaymentStatusInfo(int? status) {
      switch (status) {
        case 1:
          return {"text": "Paid", "color": Colors.green};
        case 0:
          return {"text": "Pending", "color": Colors.orange};
        case 2:
          return {"text": "Failed", "color": Colors.red};
        default:
          return {"text": "Cancelled", "color": Colors.red};
      }
    }

    final statusInfo = getPaymentStatusInfo(order?.paymentStatus);

    final paymentController = Get.find<PaymentMethodController>();

    //final orderDetailsController = Get.put(OrderDetailsController());
    if (order == null) {
      return const Scaffold(body: Center(child: Text("Order not found")));
    }

    Future<void> callDriver(String phoneNumber) async {
      final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        ToastMessage.show("Something went wrong", isSuccess: false);
      }
    }

    // ✅ Dynamic status message
    String getOrderStatusMessage() {
      switch (order.status) {
        case 0:
          return 'Waiting for Approval...';
        case 1:
          return 'Be ready with your package. Driver will arrive soon.';
        case 2:
          return 'Order Delivered Successfully';
        case 3:
          return 'Order Cancelled';
        case 4:
          return 'Order Confirmed by Vendor';
        case 5:
          return 'Order Picked Up by Driver';
        default:
          return 'Unknown Status';
      }
    }

    return WillPopScope(
      onWillPop: () async {
        final previousRoute = Get.previousRoute;

        if (previousRoute == AppRoutes.creatOrderSuccessScreen ||
            previousRoute.isEmpty) {
          // No back route, redirect to navigation menu
          Get.offAllNamed(AppRoutes.navigationMenu);
          return false; // prevent default pop behavior
        } else {
          return true; // allow default back behavior
        }
      },

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final previousRoute = Get.previousRoute;

              if (previousRoute == AppRoutes.creatOrderSuccessScreen) {
                // Navigate to History tab
                Get.offAllNamed(AppRoutes.navigationMenu);
              } else {
                Get.back();
              }
            },
          ),

          elevation: 1,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: Colors.black87),
          //   onPressed: () => Navigator.pop(context),
          // ),
          title: const Text("Order Details"),
          actions: [
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.helpCenter),
              child: const Text(
                "Support",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Status
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  getOrderStatusMessage(),
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ✅ Order Info (Logo + Vendor + Call)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _cardBox(),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        order.driverDetails?.profilePic != null
                            ? Image.network(
                              order.driverDetails!.profilePic!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) => Image.asset(
                                    TImages.defaultdp, // fallback image
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                            )
                            : Image.asset(
                              TImages.defaultdp,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                  ),
                  title: Text(
                    order.driverDetails?.name ?? "Waiting...",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),

                  subtitle: Text(
                    "Delivery Partner",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing:
                      (order.status == 0 ||
                              order.status == 2 ||
                              order.status == 3)
                          ? null
                          : IconButton(
                            onPressed: () {
                              final phone = order.driverDetails?.phoneNumber;
                              if (phone != null && phone.isNotEmpty) {
                                callDriver(phone);
                              } else {
                                ToastMessage.show(
                                  "Driver's contact not available",
                                  isSuccess: false,
                                );
                              }
                            },
                            icon: const Icon(
                              Iconsax.call,
                              color: Colors.redAccent,
                            ),
                          ),
                ),
                // trailing: IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Iconsax.call, color: Colors.redAccent),
                // ),
              ),

              const SizedBox(height: 16),

              // ✅ Order ID + total
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: _cardBox(),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Row(
              //             children: [
              //               Text(
              //                 "Order ID: ",
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.grey[800],
              //                 ),
              //               ),
              //               Text(
              //                 "${order.orderNumber ?? order.id}",
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w700,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),

              //           Text(
              //             "₹${order.total?.toStringAsFixed(2) ?? "0.00"}",
              //             style: const TextStyle(fontWeight: FontWeight.w600),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 6),
              //       Row(
              //         children: [
              //           Text(
              //             "Goods Type: ",
              //             style: TextStyle(
              //               fontWeight: FontWeight.w500,
              //               color: Colors.grey[800],
              //             ),
              //           ),
              //           Text(
              //             "${order.goodsType}",
              //             style: TextStyle(
              //               fontWeight: FontWeight.w600,
              //               color: Colors.black,
              //             ),
              //           ),
              //         ],
              //       ),
              //       // Text("Goods Type: ${order.goodsType}" , style: TextStyle(
              //       //             fontWeight: FontWeight.w500,
              //       //             color: Colors.black,
              //       //           ),),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 16),

              // ✅ Customer Info
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                decoration: _cardBox(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              height: 16,
                              width: 2,
                              color: Colors.grey.shade400,
                            ),
                            Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.red,
                            ),
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
                                order.fromLocation!.isNotEmpty
                                    ? order.fromLocation!
                                    : "Pickup Location",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 15),

                              // Delivery Address
                              Text(
                                order.destinationLocation!.isNotEmpty
                                    ? order.destinationLocation!
                                    : "Delivery Location",
                                style: TextStyle(
                                  fontSize: 14,
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
                    //  const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ✅ Customer Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _cardBox(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.person),
                      ),
                      title: Text(
                        order.receiverName ?? "Receiver ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        order.phoneNumber ?? "Receiver",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),

                    _buildRow(
                      "Order ID", // left text
                      "${order.orderNumber ?? order.id}", // right text
                      bold: true, // ✅ makes right text bold like before
                      color: Colors.black, // ✅ keep it black
                    ),

                    _buildRow("Goods Type", order.goodsType ?? "Unknown"),
                    _buildRow(
                      "Payment Method",
                      paymentController.getPaymentMethodName(
                        order.paymentMethod,
                      ),
                    ),

                    _buildRow(
                      "Payment Status",
                      statusInfo["text"],
                      color: statusInfo["color"],
                    ),

                    // _buildRow(
                    //   "Payment Status",
                    //   order.paymentStatus == 0
                    //       ? "Pending"
                    //       : order.paymentStatus == 1
                    //       ? "Paid"
                    //       : order.paymentStatus == 2
                    //       ? "Failed"
                    //       : "Cancelled",
                    //   color:
                    //       order.paymentStatus == 1
                    //           ? Colors
                    //               .green // ✅ Paid -> Green
                    //           : order.paymentStatus == 0
                    //           ? Colors
                    //               .orange // ✅ Pending -> Orange
                    //           : Colors.red, // ✅ Failed or Cancelled -> Red
                    // ),

                    // _buildRow(
                    //   "Payment Status",
                    //   order.paymentStatus == 0
                    //       ? "Pending"
                    //       : order.paymentStatus == 1
                    //       ? "Paid"
                    //       : order.paymentStatus == 2
                    //       ? "Failed"
                    //       : "Cancelled",
                    // ),
                    _buildRow("Order date", order.orderDate ?? "N/A"),
                    //   _buildRow("Updated at", _formatIndianTime(order.updatedAt)),
                    // const SizedBox(height: 8),
                    // Text(
                    //   "Destination: ${order.destinationLocation ?? "Unknown"}",
                    //   style: const TextStyle(color: Colors.black54),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // ✅ Bill Summary
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _cardBox(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bill Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildRow(
                      "Item total",
                      //  "₹${order.total?.toStringAsFixed(2) ?? "0.00"}",
                      CurrencyFormatter.format(order.total ?? 0),
                    ),
                    _buildRow(
                      "Coupon Discount",
                      "- ${CurrencyFormatter.format(order.couponAmount ?? 0)}",
                      // "- ₹${order.couponAmount?.toStringAsFixed(2) ?? "0.00"}",
                      color: Colors.green,
                    ),
                    const Divider(),
                    _buildRow(
                      "Grand total",
                      CurrencyFormatter.format(order.gtotal ?? 0),
                      // "₹${order.gtotal?.toStringAsFixed(2) ?? "0.00"}",
                      bold: true,
                    ),
                    const SizedBox(height: 12),
                    if ((order.couponAmount ?? 0) > 0)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "🎉 You saved ${CurrencyFormatter.format(order.couponAmount ?? 0)} on this order!",
                          //  "🎉 You saved ₹${order.couponAmount?.toStringAsFixed(2)} on this order!",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Invoice Button
              SafeArea(
                bottom: true,
                child: Center(
                  child: _buildActionButton(order, orderController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // // ✅ Helper to format time in IST
  // String _formatIndianTime(String? utcTime) {
  //   if (utcTime == null || utcTime.isEmpty) return "N/A";
  //   try {
  //     final dateTime = DateTime.parse(utcTime).toLocal();
  //     final ist = dateTime.add(const Duration(hours: 5, minutes: 30));
  //     return DateFormat('dd MMM yyyy, hh:mm a').format(ist);
  //   } catch (_) {
  //     return utcTime;
  //   }
  // }

  // ✅ Reusable card box decoration
  BoxDecoration _cardBox() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      //  border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(31, 54, 53, 53),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  /// Action Button (Invoice / Cancel)
  Widget _buildActionButton(
    FetchOrderModel order,
    CancelOrderController orderController,
  ) {
    final bool isOnlinePayment =
        (order.paymentMethod == 0 || order.paymentMethod == 1);
    final bool isCashPayment = order.paymentMethod == 2;

    /// ✅ CASE 1: Online Payment (Card / UPI)
    if (isOnlinePayment) {
      // Show invoice only if payment was successful
      if (order.paymentStatus == 1) {
        return TNavigationButton(
          buttonTitle: "Invoice",
          color: Colors.orange,
          onTap: () {
            print("📄 Opening invoice for order: ${order.orderNumber}");
          },
        );
      } else if (order.paymentStatus == 0) {
        // Payment Pending - Show a disabled button or info
        return TNavigationButton(
          buttonTitle: "Payment Pending",
          color: Colors.grey,
          isDisabled: true,
          onTap: () {},
        );
      } else if (order.paymentStatus == 2) {
        // Payment Failed
        return TNavigationButton(
          buttonTitle: "Retry Payment",
          color: Colors.red,
          onTap: () {
            print("🔄 Retry Payment flow for order: ${order.orderNumber}");
          },
        );
      }
    }

    /// ✅ CASE 2: Cash on Delivery
    if (isCashPayment) {
      if (order.status == 0) {
        // Order placed but not delivered → allow cancellation
        return Obx(() {
          return TNavigationButton(
            buttonTitle:
                orderController.isCancelling.value ? "" : "Cancel Order",
            color: Colors.red,
            onTap:
                orderController.isCancelling.value
                    ? () {}
                    : () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text("Cancel Order"),
                          content: const Text(
                            "Are you sure you want to cancel this order? This action cannot be undone.",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text(
                                "Keep Order",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back(); // close dialog
                                final token = PreferenceUtils.getUserToken();
                                orderController.cancelOrder(order.id, token);
                              },
                              child: const Text(
                                "Yes, Cancel",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
            child:
                orderController.isCancelling.value
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : null,
          );
        });
      } else if (order.status == 2) {
        // Order Delivered → Show Invoice
        return TNavigationButton(
          buttonTitle: "Invoice",
          color: Colors.orange,
          onTap: () {
            print("📄 Opening invoice for COD order: ${order.orderNumber}");
          },
        );
      }
    }

    /// ✅ CASE 3: For cancelled (3), confirmed (4), picked up (5)
    return const SizedBox.shrink();
  }

  // /// Action Button (Invoice / Cancel)
  // Widget _buildActionButton(
  //   FetchOrderModel order,
  //   CancelOrderController orderController,
  // ) {
  //   // ✅ Always show Invoice if payment method is 0 or 1
  //   if (order.paymentMethod == 0 || order.paymentMethod == 1) {
  //     return TNavigationButton(
  //       buttonTitle: "Invoice",
  //       color: Colors.orange,
  //       onTap: () {},
  //     );
  //   } else if (order.paymentMethod == 2) {
  //     if (order.status == 0) {
  //       return Obx(() {
  //         return TNavigationButton(
  //           buttonTitle:
  //               orderController.isCancelling.value ? "" : "Cancel Order",
  //           color: Colors.red,
  //           onTap:
  //               orderController.isCancelling.value
  //                   ? () {}
  //                   : () {
  //                     // Show confirmation dialog
  //                     Get.dialog(
  //                       AlertDialog(
  //                         title: const Text("Cancel Order"),
  //                         content: const Text(
  //                           "Are you sure you want to cancel this order?",
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 15,
  //                           ),
  //                         ),
  //                         actions: [
  //                           TextButton(
  //                             onPressed: () => Get.back(),
  //                             child: const Text(
  //                               "No",
  //                               style: TextStyle(fontWeight: FontWeight.w700),
  //                             ),
  //                           ),
  //                           TextButton(
  //                             onPressed: () {
  //                               Get.back(); // close dialog
  //                               final token = PreferenceUtils.getUserToken();
  //                               orderController.cancelOrder(order.id, token);
  //                             },
  //                             child: const Text(
  //                               "Yes, Cancel",
  //                               style: TextStyle(
  //                                 color: Colors.red,
  //                                 fontWeight: FontWeight.w700,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //           child:
  //               orderController.isCancelling.value
  //                   ? const SizedBox(
  //                     height: 20,
  //                     width: 20,
  //                     child: CircularProgressIndicator(
  //                       strokeWidth: 2,
  //                       color: Colors.white,
  //                     ),
  //                   )
  //                   : null, // If not loading, fallback to buttonTitle
  //         );
  //       });
  //     } else if (order.status == 2) {
  //       // ✅ Invoice Button after delivered
  //       return ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 14),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           backgroundColor: Colors.redAccent,
  //         ),
  //         onPressed: () {},
  //         child: const Text("Invoice"),
  //       );
  //     } else if (order.status == 1) {
  //       return const SizedBox.shrink();
  //     }
  //   }

  //   // ❌ For status 3, 4, 5 → No button
  //   return const SizedBox.shrink();
  // }

  // ✅ Row widget
  static Widget _buildRow(
    String left,
    String right, {
    String? strike,
    bool bold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(left)),
          Row(
            children: [
              if (strike != null)
                Text(
                  strike,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              const SizedBox(width: 4),
              Text(
                right,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                  color: color ?? Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
