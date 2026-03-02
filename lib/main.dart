// ignore_for_file: deprecated_member_use, avoid_print

import 'package:ev/bindings/app_binding.dart';
import 'package:ev/controller/fetch_order_controller.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/navigation_menu.dart';
import 'package:ev/utils/colors.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:ev/utils/theme.dart';
import 'package:ev/view/auth/company_details/company_details_screen.dart';
import 'package:ev/view/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize PreferenceUtils (SharedPreferences wrapper)
  await PreferenceUtils.init();

  // User login check
  final userId = PreferenceUtils.getUserId();
  final isLoggedIn = userId != -1;

  // Profile completion check
  // final name = PreferenceUtils.getString('name');
  // final companyName = PreferenceUtils.getString('company_name');
  // final gstDetails = PreferenceUtils.getString('gst_details');
  final name = PreferenceUtils.getUserName();
  final companyName = PreferenceUtils.getCompanyName();
  final gstDetails = PreferenceUtils.getGstDetails();

  print("DEBUG PREFS ===");
  print("Name from prefs: $name");
  print("Company from prefs: $companyName");
  print("GST from prefs: $gstDetails");

  final isProfileComplete =
      name.isNotEmpty && companyName.isNotEmpty && gstDetails.isNotEmpty;

  debugPrint('✅ Is logged in: $isLoggedIn');
  debugPrint('✅ Is profile complete: $isProfileComplete');

  Get.put(FetchOrderController());

  // Run the app and pass the flags
  runApp(
    EvCourier(
      // hasSeenOnboarding: hasSeenOnboarding,
      isLoggedIn: isLoggedIn,
      isProfileComplete: isProfileComplete,
    ),
  );
}

class EvCourier extends StatelessWidget {
  //  final bool hasSeenOnboarding;
  final bool isLoggedIn;
  final bool isProfileComplete;
  const EvCourier({
    super.key,
    //  required this.hasSeenOnboarding,
    required this.isLoggedIn,
    required this.isProfileComplete,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EV',
      debugShowCheckedModeBanner: false,
      // initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
      //defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 200),

      defaultTransition: Transition.rightToLeft,
      initialBinding: AppBinding(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'InterTight',
         textTheme: const TextTheme(
    bodyLarge: TextStyle(letterSpacing: 0.5),
    bodyMedium: TextStyle(letterSpacing: 0.5),
    bodySmall: TextStyle(letterSpacing: 0.5),
    titleLarge: TextStyle(letterSpacing: 0.8),
    titleMedium: TextStyle(letterSpacing: 0.8),
    titleSmall: TextStyle(letterSpacing: 0.8),
    labelLarge: TextStyle(letterSpacing: 0.6),
    labelMedium: TextStyle(letterSpacing: 0.6),
    labelSmall: TextStyle(letterSpacing: 0.6),
  ),

      //  scaffoldBackgroundColor: Colors.white,
      scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 251),
        primaryColor: TColors.primary,

        // The key change here
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColors.primary,
          primary: TColors.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,

          elevation: 2,
          shadowColor: Colors.black26,
          surfaceTintColor: Colors.white,

          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),

        //Textbutton theme
        textButtonTheme: TextButtonThemeData(),

        //  🔷 Global AlertDialog / Dialog theme
        dialogTheme: DialogThemeData(
          //shadowColor: Colors.black38,
          backgroundColor: Colors.white,
     //  contentTextStyle: TextStyle(fontSize: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: const TextStyle(
            
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),

          // contentTextStyle: const TextStyle(
          //   fontSize: 15,
          //   color: Colors.black54,
          // ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white,
          showDragHandle: true,
          dragHandleColor: Colors.grey,
        ),

        tabBarTheme: const TabBarThemeData(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: TextBoxTheme.lightInputDecorationTheme,
      ),
   // home: CompanyDetailsScreen(),
      home:
          !isLoggedIn
              ? LoginScreen(isLoggedIn: isLoggedIn)
              : (isProfileComplete ? NavigationMenu() : CompanyDetailsScreen()),

     
    );
  }
}
