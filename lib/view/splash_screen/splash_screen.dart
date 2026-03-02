// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:ev/navigation_menu.dart';
// import 'package:ev/utils/image.strings.dart';
// import 'package:ev/view/auth/login/login_screen.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//    //final bool hasSeenOnboarding;
//   final bool isLoggedIn;
//   const SplashScreen({super.key, required this.isLoggedIn, 
//  // required this.hasSeenOnboarding
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       splash: Center(child: Image.asset(TImages.appLogo, width: 200)),
//       splashTransition: SplashTransition.fadeTransition,
//       nextScreen: isLoggedIn ? NavigationMenu() : LoginScreen(),
        
//       // nextScreen: hasSeenOnboarding
//       //     ? (isLoggedIn ? NavigationMenu() : LoginScreen())
//       //     : OnboardingScreen(),
//       duration: 3500,
//       backgroundColor: Colors.white,
//     );
//   }
// }
