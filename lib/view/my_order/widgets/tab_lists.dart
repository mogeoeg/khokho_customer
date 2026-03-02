// ignore_for_file: deprecated_member_use, avoid_print

import 'package:ev/controller/fetch_order_controller.dart';
import 'package:ev/helper/model/fetch_order_model.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/utils/colors.dart';
import 'package:ev/utils/image.strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class OrderListTab extends StatefulWidget {
  const OrderListTab({super.key});

  @override
  State<OrderListTab> createState() => _OrderListTabState();
}

class _OrderListTabState extends State<OrderListTab>
    with SingleTickerProviderStateMixin {
  final _fetchOrderController = Get.find<FetchOrderController>();
  


  String selectedStatus = 'All';

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchOrderController
  //       .fetchOrders(); // 🔁 This refreshes every time widget is loaded
  // }

  @override
  void initState() {
    super.initState();
    if (_fetchOrderController.orders.isEmpty) {
      _fetchOrderController.fetchOrders();
    }
  }

  // Color getStatusColor(String status) {
  //   switch (status) {
  //     case 'Delivered':
  //       return const Color.fromARGB(255, 32, 215, 218);
  //     case 'Pending':
  //       return Colors.green;
  //     case 'Onprocess':
  //       return Colors.orange;
  //     case 'Cancelled':
  //       return Colors.red;
  //     default:
  //       return Colors.grey;
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

  @override
  Widget build(BuildContext context) {
    // final List<String> statuses = [
    //   'All',
    //   'Delivered',
    //   'Pending',
    //   'Onprocess',
    //   'Cancelled',
    // ];

    final List<String> statuses = [
      'All',
      'Pending',
      'Onprocess',
      'Confirmed', // 🔹 added
      'PickUp', // 🔹 added
      'Delivered',
      'Cancelled',
    ];

    // final List<String> statuses = [
    //   'All',
    //   'Delivered',
    //   'Pending',
    //   'Onprocess',
    //   'Cancelled',
    //   'Confirmed', // 🔹 Added
    //   'PickUp', // 🔹 Added
    // ];

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

    return Obx(() {
      final allOrders = _fetchOrderController.orders;

      // Create a copy before filtering and sorting
      final List<FetchOrderModel> filteredOrders =
          (selectedStatus == 'All'
                  ? allOrders
                  : allOrders.where(
                    (order) => order.statusText == selectedStatus,
                  ))
              .toList();

      filteredOrders.sort((a, b) {
        final dateA = DateTime.tryParse(a.updatedAt ?? '') ?? DateTime(0);
        final dateB = DateTime.tryParse(b.updatedAt ?? '') ?? DateTime(0);
        return dateB.compareTo(dateA); // 🔁 Sort: Newest first
      });

      return Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: statuses.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final status = statuses[index];
                  final isSelected = selectedStatus == status;

                  return FilterChip(
                    label: Text(status),
                    selected: isSelected,
                    selectedColor: TColors.primary.withOpacity(0.2),
                    backgroundColor: Colors.grey.shade200,
                    onSelected: (_) {
                      setState(() => selectedStatus = status);
                    },
                    labelStyle: TextStyle(
                      color: isSelected ? TColors.primary : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
              ),
            ),
          ),

          // Order List
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchOrderController.fetchOrders,
              child:filteredOrders.isEmpty
        ? SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🖼️ Add your image asset here
                    Image.asset(
                      TImages.emptryOrder, // ✅ Make sure this image exists
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No Orders Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Your orders will appear here once you place one.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        :
               ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                itemCount: filteredOrders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];

                  final rawDateStr = order.updatedAt ?? '';
                  final utcDate = DateTime.parse(
                    "${rawDateStr}Z",
                  ); // Now parsed as UTC
                  final istDate = utcDate.add(
                    const Duration(hours: 5, minutes: 30),
                  );

                  print(
                    "🕒 Raw: $rawDateStr | Parsed UTC: $utcDate | IST: $istDate",
                  );

                  final formattedDate = DateFormat(
                    'dd MMM yyyy • h:mm a',
                  ).format(istDate);

                  return Material(
                    color: Colors.grey.shade50,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      // side: BorderSide(color: TColors.primary),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap:
                          () => Get.toNamed(
                            AppRoutes.orderStatus,
                            arguments: order,
                          ),

                       

                      child: Container(
                        decoration: _cardBox(),
                        padding: const EdgeInsets.all(12),
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.grey.shade300),
                        //   borderRadius: BorderRadius.circular(12),
                        // ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: getStatusColor(
                                  order.statusText,
                                ).withOpacity(0.2),
                                border: Border.all(
                                  color:
                                  // TColors.primary
                                  getStatusColor(order.statusText),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                getStatusIcon(order.statusText),
                                color: getStatusColor(order.statusText),
                              ),
                              // child: Icon(
                              //   Iconsax.box,
                              //   color:
                              //   //Colors.green.shade700,
                              //   getStatusColor(order.statusText),
                              // ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.orderNumber ?? 'Order ID',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2),

                                  // ✅ New lines for Pickup & Delivery Address
                                  if (order.fromLocation != null &&
                                      order.fromLocation!.isNotEmpty &&
                                      order.destinationLocation != null &&
                                      order.destinationLocation!.isNotEmpty)
                                    Text(
                                      "${order.fromLocation} - ${order.destinationLocation} ",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                         fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade800,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4,),
                                     if (formattedDate.isNotEmpty)
                                    Text(
                                      formattedDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  // if (order.destinationLocation != null &&
                                  //     order.destinationLocation!.isNotEmpty)
                                  //   Text(
                                  //     "Delivery: ${order.destinationLocation}",
                                  //     style: TextStyle(
                                  //       color: Colors.grey.shade700,
                                  //       fontSize: 13,
                                  //     ),
                                  //   ),

                                  //Text(order.orderDate ?? ''),
                                ],
                              ),
                            ),
                             const SizedBox(width: 8),
                            Text(
                              order.statusText,
                              style: TextStyle(
                                color: getStatusColor(order.statusText),
                               fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
