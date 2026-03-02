// import 'package:flutter/material.dart';

// class TInfoRow extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String value;

//   final Color? iconColor;
//   final Color? textColor;

//   const TInfoRow({
//     super.key,
//     required this.icon,
//     required this.title,
//     this.iconColor,
//     this.textColor,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(icon, size: 20, color: iconColor ?? Colors.grey),
//               const SizedBox(width: 8),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               color: textColor ?? Colors.black,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
