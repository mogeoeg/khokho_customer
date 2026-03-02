// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ev/controller/otp_controller.dart';
// import 'package:ev/view/auth/otp_verification/widgets/otp_single_box.dart';

// class TOTPBody extends StatelessWidget {
//   TOTPBody({super.key});
//   final OtpController controller = Get.find<OtpController>();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Form(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(
//               6,
//               (index) => Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: TOtpSingleBox(
//                     controller: controller.otpControllers[index],
//                     onChanged: (value) {
//                       if (value.length == 1 && index < 5) {
//                         FocusScope.of(context).nextFocus();
//                       } else if (value.isEmpty && index > 0) {
//                         FocusScope.of(context).previousFocus();
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 32),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Didn\'t get OTP Code?'),
//             const SizedBox(width: 8),
//             InkWell(
//               onTap: controller.resendOtp,
//               child: const Text(
//                 'Send Again',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
