// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class TOtpSingleBox extends StatelessWidget {
//   final TextEditingController controller;
//   final void Function(String) onChanged;

//   const TOtpSingleBox({
//     super.key,
//     required this.controller,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4),
//       child: SizedBox(
//         height: 46,
//         width: 46,
//         child: TextFormField(
//           controller: controller,
//           onChanged: onChanged,
//           keyboardType: TextInputType.number,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 16, height: 1),
//           inputFormatters: [
//             LengthLimitingTextInputFormatter(1),
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:ev/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:ev/controller/otp_controller.dart';

// class TOTPBody extends StatelessWidget {
//   TOTPBody({super.key});
//   final OtpController controller = Get.find<OtpController>();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // ✅ OTP Box Input
//         Obx(() => PinFieldAutoFill(
//               codeLength: 6,
//               controller: controller.otpMainController,
//               currentCode: controller.otpValue.value,
//               onCodeChanged: (value) {
//                 controller.otpValue.value = value ?? '';
//               },
//               decoration: UnderlineDecoration(
//                 textStyle: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 colorBuilder: FixedColorBuilder(
//                   controller.otpValue.value.length == 6
//                       ? TColors.primary
//                       : Colors.grey,
//                 ),
//               ),
//             )),
//         const SizedBox(height: 32),

//         // ✅ Countdown + Resend Button
//         Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 controller.secondsRemaining.value > 0
//                     ? "Resend OTP in ${controller.secondsRemaining.value}s"
//                     : "Didn’t get OTP?",
//               ),
//               if (controller.secondsRemaining.value == 0) ...[
//                 const SizedBox(width: 8),
//                 InkWell(
//                   onTap: controller.isLoading.value
//                       ? null
//                       : controller.resendOtp, // disable if loading
//                   child: Text(
//                     'Send Again',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: controller.isLoading.value
//                           ? Colors.grey
//                           : Colors.blue,
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:ev/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:ev/controller/otp_controller.dart';

// class TOTPBody extends StatelessWidget {
//   TOTPBody({super.key});
//   final OtpController controller = Get.find<OtpController>();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 40),

//         // Single TextField for OTP
//         Obx(() => TextFieldPinAutoFill(
//               codeLength: 6,
//               currentCode: controller.otpValue.value,
//               onCodeChanged: (value) {
//                 controller.otpValue.value = value ;
//                 controller.otpMainController.text = value ;
//                 debugPrint("🔹 OTP changed: ${controller.otpValue.value}");
//               },
//               decoration: InputDecoration(
//                 hintText: "Enter OTP",
//                 hintStyle: TextStyle(color: Colors.grey[400]),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: TColors.primary, width: 2),
//                 ),
//               ),
//               // keyboardType: TextInputType.number,
//               // autofocus: true,
//             )),

//         const SizedBox(height: 16),

//         // Countdown timer
//         Obx(() => Text(
//               controller.secondsRemaining.value > 0
//                   ? "Resend OTP in ${controller.secondsRemaining.value}s"
//                   : "Didn't receive OTP?",
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             )),

//         const SizedBox(height: 8),

//         // Resend Button
//         Obx(() => Visibility(
//               visible: controller.secondsRemaining.value == 0,
//               child: TextButton(
//                 onPressed: controller.isLoading.value
//                     ? null
//                     : controller.resendOtp,
//                 style: TextButton.styleFrom(
//                   foregroundColor: TColors.primary,
//                   textStyle: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 child: Text(
//                     controller.isLoading.value ? "Sending..." : "Resend OTP"),
//               ),
//             )),
//       ],
//     );
//   }
// }
