// import 'package:ev/common/body_title.dart';
// import 'package:ev/helper/model/fetch_order_model.dart';
// import 'package:ev/utils/colors.dart';
// import 'package:ev/view/my_order/widgets/info_row_widget.dart';
// import 'package:flutter/material.dart';

// class TCommonOrderInfoContainer extends StatelessWidget {
//   const TCommonOrderInfoContainer({super.key, required this.order});

//   final FetchOrderModel order;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.grey.shade50,
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const TBodyTitle(title: 'Order Info'),
//           const SizedBox(height: 8),
//           TInfoRow(
//             icon: Icons.category,
//             title: "Goods Type",
//             value: order.goodsType ?? "-",
//             iconColor: TColors.primary,
//           ),
//           const SizedBox(height: 10),
//           TInfoRow(
//             icon: Icons.work_outline,
//             title: "Service Size",
//             value: order.serviceName ?? "-",
//             iconColor: TColors.primary,
//           ),
//           const SizedBox(height: 10),
//           TInfoRow(
//             icon: Icons.person,
//             title: "Receiver Name",
//             value: order.receiverName ?? "-",
//             iconColor: TColors.primary,
//           ),
//           const SizedBox(height: 10),
//           TInfoRow(
//             icon: Icons.phone,
//             title: "Receiver Phone Number",
//             value: "+91 ${order.phoneNumber}",
//             iconColor: TColors.primary,
//           ),
//           const SizedBox(height: 10),
//           if ((order.mail ?? "").trim().isNotEmpty)
//             TInfoRow(
//               icon: Icons.email,
//               title: "Receiver Mail ID",
//               value: order.mail!,
//               //value:order.mail?? "-",
//               iconColor: TColors.primary,
//             ),
//           const SizedBox(height: 10),
//           TInfoRow(
//             icon: Icons.payments,
//             title: "Total Amount",
//             value: "₹${order.gtotal?.toStringAsFixed(2) ?? '0.00'}",
//             iconColor: TColors.primary,
//             textColor: TColors.primary,
//           ),
//         ],
//       ),
//     );
//   }
// }
