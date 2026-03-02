// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:ev/utils/colors.dart'; // Make sure TColors.primary is defined

// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});

//   final List<Map<String, String>> notifications = const [
//     {
//       "icon": "message",
//       "title": "Kathryn Sent You a Message",
//       "subtitle": "Tap to see the message.",
//       "time": "2 min ago",
//     },
//     {
//       "icon": "local_shipping",
//       "title": "Your Shipping Already Delivered ",
//       "subtitle": "Tap to see the detail shipping",
//       "time": "7 min ago",
//     },
//     {
//       "icon": "new_releases",
//       "title":
//           "Try The Latest Service From Tracky! Latest Service From Tracky!",
//       "subtitle": "Let’s try the feature we provide",
//       "time": "2 min ago",
//     },
//     {
//       "icon": "percent",
//       "title": "Get 20% Discount for First Transaction!",
//       "subtitle": "For all transaction without requirements",
//       "time": "10 min ago",
//     },
//     {
//       "icon": "message",
//       "title": "Kathryn Sent You a Message",
//       "subtitle": "Tap to see the message.",
//       "time": "2 min ago",
//     },
//     {
//       "icon": "local_shipping",
//       "title": "Your Shipping Already Delivered ",
//       "subtitle": "Tap to see the detail shipping",
//       "time": "7 min ago",
//     },
//     {
//       "icon": "new_releases",
//       "title":
//           "Try The Latest Service From Tracky! Latest Service From Tracky!",
//       "subtitle": "Let’s try the feature we provide",
//       "time": "2 min ago",
//     },
//     {
//       "icon": "percent",
//       "title": "Get 20% Discount for First Transaction!",
//       "subtitle": "For all transaction without requirements",
//       "time": "10 min ago",
//     },
//     {
//       "icon": "message",
//       "title": "Kathryn Sent You a Message",
//       "subtitle": "Tap to see the message.",
//       "time": "2 min ago",
//     },
//     {
//       "icon": "local_shipping",
//       "title": "Your Shipping Already Delivered ",
//       "subtitle": "Tap to see the detail shipping",
//       "time": "7 min ago",
//     },
//     {
//       "icon": "new_releases",
//       "title":
//           "Try The Latest Service From Tracky! Latest Service From Tracky!",
//       "subtitle": "Let’s try the feature we provide",
//       "time": "2 min ago",
//     },
//     {
//       "icon": "percent",
//       "title": "Get 20% Discount for First Transaction!",
//       "subtitle": "For all transaction without requirements",
//       "time": "10 min ago",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notification"),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: TextButton(
//               onPressed: () {},
//               child: const Text(
//                 "Clear All",
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6),
//         child: ListView.builder(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//           itemCount: notifications.length,
//           //  separatorBuilder: (_, __) => const SizedBox(height: 12),
//           itemBuilder: (context, index) {
//             final item = notifications[index];
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Icon Circle
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: TColors.primary.withOpacity(0.15),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           _getIconData(item["icon"] ?? ""),
//                           color: TColors.primary,
//                           size: 20,
//                         ),
//                       ),

//                       const SizedBox(width: 12),
//                       // Title + Subtitle + Time
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Title
//                                 Expanded(
//                                   child: Text(
//                                     item["title"] ?? "",
//                                     maxLines: 2,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 // Time
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   item["time"] ?? "",
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 4),
//                             // Subtitle
//                             Text(
//                               item["subtitle"] ?? "",
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Divider(color: Colors.grey.shade300),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   IconData _getIconData(String name) {
//     switch (name) {
//       case "message":
//         return Icons.message;
//       case "local_shipping":
//         return Icons.local_shipping;
//       case "new_releases":
//         return Icons.new_releases;
//       case "percent":
//         return Icons.percent;
//       default:
//         return Icons.notifications;
//     }
//   }
// }
