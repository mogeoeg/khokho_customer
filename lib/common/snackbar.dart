// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustomSnackbar {
//   static void showSnack(String title, String message, bool isSuccess) {
//     Get.snackbar(
//       "",
//       "", // leave empty for custom layout
//       titleText: Row(
//         children: [
//           Icon(
//             isSuccess ? Icons.check_circle : Icons.cancel,
//             color: isSuccess ? Colors.green : Colors.red,
//             size: 26,
//           ),
//           SizedBox(width: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),

//       messageText: Padding(
//         padding: const EdgeInsets.only(left: 34),
//         child: Text(
//           message,
//           style: TextStyle(fontSize: 14, color: Colors.black),
//         ),
//       ),
//       snackPosition: SnackPosition.TOP,
//       backgroundColor: Colors.white,
//       borderRadius: 10,
//       margin: EdgeInsets.only(top: 8, left: 16, right: 16),
//       padding: EdgeInsets.all(16),
//       boxShadows: [
//         BoxShadow(
//           // ignore: deprecated_member_use
//           color: Colors.black.withOpacity(0.1),
//           blurRadius: 10,
//           offset: Offset(0, 2),
//         ),
//       ],
//       duration: Duration(seconds: 2),
//       isDismissible: true,
//     );
//   }
// }
