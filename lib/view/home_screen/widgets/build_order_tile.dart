// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TBuildOrderTile extends StatelessWidget {
  const TBuildOrderTile({
    super.key,
    required this.id,
    required this.status,
    required this.time,
    required this.fromAddress, // ✅ new
    required this.toAddress,
    this.onTap,
  });

  final String id;
  final String status;
  final String time;
  final VoidCallback? onTap;
  final String fromAddress; // ✅ new
  final String toAddress;

  Color getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return const Color.fromARGB(255, 32, 215, 218); // cyan
      case 'Pending':
        return Colors.green;
      case 'Onprocess':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      case 'Confirmed':
        return Colors.blue; // 🔹 New status
      case 'PickUp':
        return Colors.purple; // 🔹 New status
      default:
        return Colors.grey;
    }
  }

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

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Pending":
        return Iconsax.clock;
      case "Onprocess":
        return Iconsax.truck_fast;
      case "Confirmed":
        return Iconsax.verify;
      case "PickUp":
        return Iconsax.box;
      case "Delivered":
        return Iconsax.tick_circle;
      case "Cancelled":
        return Iconsax.close_circle;
      default:
        return Iconsax.info_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(status);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: _cardBox(),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.grey.shade300),
        //   borderRadius: BorderRadius.circular(12),
        // ),
        // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // ✅ top alignment
          children: [
            // Leading icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                border: Border.all(color: statusColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(getStatusIcon(status), color: getStatusColor(status)),

              // Icon(Iconsax.box, color: statusColor),
            ),
            const SizedBox(width: 12),
            // Middle: Title + Time + From-To
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  
                  Text(
                    "$fromAddress - $toAddress",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                      fontSize: 14,
                    ),
                  ),
                   const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                 
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Trailing: Status
            Text(
              status,
              style: TextStyle(
                color: statusColor,

                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final statusColor = getStatusColor(status);

  //   return InkWell(
  //     borderRadius: BorderRadius.circular(12),
  //     onTap: onTap,
  //     child: ListTile(
  //       contentPadding: const EdgeInsets.only(left: 0, right: 6),
  //       leading: Container(
  //         padding: const EdgeInsets.all(12),
  //         decoration: BoxDecoration(
  //           color: statusColor.withOpacity(0.2),
  //           border: Border.all(color: statusColor),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Icon(Iconsax.box, color: statusColor),
  //       ),
  //       title: Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
  //       subtitle: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(time, style: const TextStyle(color: Colors.black54)),
  //           const SizedBox(height: 4),
  //           Text("$fromAddress - $toAddress", style: const TextStyle(color: Colors.black87, fontSize: 13)),
  //          // Text("To: ", style: const TextStyle(color: Colors.black87, fontSize: 13)),
  //         ],
  //       ),
  //     //  subtitle: Text(time, style: const TextStyle(color: Colors.black54)),
  //       trailing: Text(
  //         status,
  //         style: TextStyle(
  //           color: statusColor,
  //           fontWeight: FontWeight.w500,
  //           fontSize: 14,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

//  child: Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: getStatusColor(
//                                   order.statusText,
//                                 ).withOpacity(0.2),
//                                 border: Border.all(
//                                   color:
//                                   // TColors.primary
//                                   getStatusColor(order.statusText),
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Icon(
//                                 getStatusIcon(order.statusText),
//                                 color: getStatusColor(order.statusText),
//                               ),
//                               // child: Icon(
//                               //   Iconsax.box,
//                               //   color:
//                               //   //Colors.green.shade700,
//                               //   getStatusColor(order.statusText),
//                               // ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     order.orderNumber ?? 'Order ID',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   if (formattedDate.isNotEmpty)
//                                     Text(
//                                       formattedDate,
//                                       style: TextStyle(
//                                         color: Colors.grey.shade600,
//                                         fontSize: 13,
//                                       ),
//                                     ),

//                                   // ✅ New lines for Pickup & Delivery Address
//                                   if (order.fromLocation != null &&
//                                       order.fromLocation!.isNotEmpty &&
//                                       order.destinationLocation != null &&
//                                       order.destinationLocation!.isNotEmpty)
//                                     Text(
//                                       "${order.fromLocation} - ${order.destinationLocation} ",
//                                       style: TextStyle(
//                                         color: Colors.grey.shade700,
//                                         fontSize: 13,
//                                       ),
//                                     ),
//                                   // if (order.destinationLocation != null &&
//                                   //     order.destinationLocation!.isNotEmpty)
//                                   //   Text(
//                                   //     "Delivery: ${order.destinationLocation}",
//                                   //     style: TextStyle(
//                                   //       color: Colors.grey.shade700,
//                                   //       fontSize: 13,
//                                   //     ),
//                                   //   ),

//                                   //Text(order.orderDate ?? ''),
//                                 ],
//                               ),
//                             ),
//                             Text(
//                               order.statusText,
//                               style: TextStyle(
//                                 color: getStatusColor(order.statusText),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
