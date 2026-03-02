// import 'package:ev/common/button.dart';
// import 'package:ev/common/policy_text.dart';
// import 'package:ev/helper/routes/navigation.dart';
// import 'package:ev/utils/image.strings.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 500,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(TImages.logHeader),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           SizedBox(height: 32),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   Text(
//                     "Delivery Right to your Door Step",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Our delivery will ensure your items are delivered\nright to the door steps",
//                     textAlign: TextAlign.center,
//                     //style: TextStyle(fontSize: 24),
//                   ),
//                   //Spacer(),
//                   SizedBox(height: 32),
//                   TNavigationButton(
//                     buttonTitle: 'Join Us',
//                     onTap: () async {
//                       final prefs = await SharedPreferences.getInstance();
//                       await prefs.setBool(
//                         'seen_onboarding',
//                         true,
//                       ); // ✅ Set onboarding completed
//                       Get.offAllNamed(AppRoutes.loginScreen);
//                     },
//                   ),

//                   Spacer(),
//                   SafeArea(bottom: true, child: PolicyText()),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
