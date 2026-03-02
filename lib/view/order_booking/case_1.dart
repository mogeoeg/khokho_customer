// import 'package:ev/common/outlined_button.dart';
// import 'package:ev/helper/routes/navigation.dart';
// import 'package:ev/utils/image.strings.dart';
// import 'package:ev/view/order_booking/widgets/1_track_details_column.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dash/flutter_dash.dart';
// import 'package:get/get.dart';

// class TUnifiedTrackingSheet extends StatefulWidget {
//   const TUnifiedTrackingSheet({super.key});

//   @override
//   State<TUnifiedTrackingSheet> createState() => _TUnifiedTrackingSheetState();
// }

// class _TUnifiedTrackingSheetState extends State<TUnifiedTrackingSheet> {
//   @override
//   Widget build(BuildContext context) {
//     int trackingStep = 0; // 0 to 3

//     // Sample checkpoints (can be dynamic)
//     final List<Map<String, String>> steps = [
//       {
//         "label": "Driver started the ride",
//         "location": "Driver's current location",
//       },
//       {
//         "label": "Reached giver location",
//         "location": "1213 Washington Blvd, Belpre, OH",
//       },
//       {
//         "label": "Started delivery to receiver",
//         "location": "En route to receiver",
//       },
//       {
//         "label": "Reached receiver location",
//         "location": "121 Pike St, Marietta, OH",
//       },
//     ];
//     return Column(
//       children: [
//         // Drag Handle
//         Container(
//           width: 40,
//           height: 4,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         const SizedBox(height: 16),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             Text(
//               "Be Ready with your package",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 4),
//             Text(
//               "Arriving at pick up point in 2 mins",
//               style: TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 4),
//             Divider(color: Colors.grey.shade200),

//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: CircleAvatar(
//                 backgroundImage: AssetImage(TImages.defaultdp),
//               ),
//               title: Text("Harry Johnson"),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.call, color: Colors.black),
//                   SizedBox(width: 8),
//                   Icon(Icons.message, color: Colors.green),
//                 ],
//               ),
//             ),

//             Divider(color: Colors.grey.shade200),

//             // const SizedBox(height: 8),
//             const SizedBox(height: 2),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   TTrackDetailColumn(info: 'MM09130520', topic: 'Track Number'),
//                   TTrackDetailColumn(info: "1–3 Hours", topic: 'Estimate Time'),
//                   TTrackDetailColumn(info: '5.5 Kg', topic: 'Package Weight'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 2),
//             Divider(color: Colors.grey.shade200),
//             const SizedBox(height: 4),

//             // Step List with dotted timeline lines
//             ...List.generate(steps.length, (index) {
//               final isDone = trackingStep >= index;
//               final step = steps[index];

//               return Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Icon and Dotted Line Column
//                   Column(
//                     children: [
//                       Icon(
//                         index == steps.length - 1
//                             ? Icons.location_on
//                             : Icons.radio_button_checked,
//                         color: isDone ? Colors.green : Colors.grey,
//                       ),
//                       if (index < steps.length - 1)
//                         Dash(
//                           direction: Axis.vertical,
//                           length: 40,
//                           dashLength: 4,
//                           dashColor:
//                               isDone ? Colors.green : Colors.grey.shade400,
//                         ),
//                     ],
//                   ),
//                   const SizedBox(width: 12),
//                   // Step Text Info
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             step["label"]!,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: isDone ? Colors.black : Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             step["location"]!,
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),

//             const SizedBox(height: 16),

//             // Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: TOutlinedButton(
//                     buttonTitle: "Temp Success",
//                     onTap: () => Get.toNamed(AppRoutes.creatOrderSuccessScreen),
//                   ),
//                 ),
//                 SizedBox(width: 10),

//                 if (trackingStep < 1) // Show only before reaching giver
//                   Expanded(
//                     child: TOutlinedButton(
//                       color: Colors.red,
//                       buttonTitle: "Cancel the Order",
//                       onTap: () {},
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
