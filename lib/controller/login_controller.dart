// import 'package:ev/common/snackbar.dart';
// import 'package:ev/helper/api/login_api_service.dart';
// import 'package:ev/helper/model/login_user_model.dart';
// import 'package:ev/helper/routes/navigation.dart';
// import 'package:get/get.dart';

// class LoginAuthController extends GetxController {
//   final LoginAuthProvider authProvider = LoginAuthProvider();

//   var isLoading = false.obs;
//   var user = Rxn<LoginUserModel>();

//   Future<void> login(String email) async {
//     try {
//       isLoading.value = true;

//       // ✅ Navigate immediately
//       Get.toNamed(AppRoutes.otpScreen, arguments: {'email': email});

//       // 🔄 Now call API in the background
//       final result = await authProvider.loginWithEmail(email);

//       if (result != null) {
//         user.value = result;
//         // You could optionally show a success snackbar here
//       } else {}
//     } catch (e) {
//       CustomSnackbar.showSnack('Login Failed', e.toString(), false);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// ignore_for_file: avoid_print

import 'package:ev/helper/api/login_api_service.dart';
import 'package:ev/helper/model/login_user_model.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAuthController extends GetxController {
  final LoginAuthProvider authProvider = LoginAuthProvider();

  var isLoading = false.obs;
  var user = Rxn<LoginUserModel>();

  // Add this line
  var phoneNumber = ''.obs;
  final phoneController = TextEditingController();

  bool get isButtonActive => phoneNumber.value.length == 10;
  bool get isPhoneValid => RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber.value);

  @override
  void onInit() {
    super.onInit();
    phoneController.text = phoneNumber.value;
    phoneController.addListener(() {
      phoneNumber.value = phoneController.text;
    });
  }



  
Future<void> login(String phoneNumber) async {
  try {
    isLoading.value = true;

    final result = await authProvider.loginWithPhone(phoneNumber);

    if (result != null && result.phoneNumber != null) {
      user.value = result;

      // Save phone number
      await PreferenceUtils.saveUserPhoneNumber(result.phoneNumber!);

      // Navigate after success
      Get.toNamed(
        AppRoutes.otpScreen,
        arguments: {'phone_number': result.phoneNumber!},
      );
    } else {
      print("⚠️ Login failed, API did not return valid phone number");
    }
  } catch (e) {
    print("❌ Exception during login: $e");
  } finally {
    isLoading.value = false;
  }
}


  // Future<void> login(String phoneNumber) async {
  //   try {
  //     isLoading.value = true;
      

  //     // ✅ Navigate immediately
  //     Get.toNamed(
  //       AppRoutes.otpScreen,
  //       arguments: {'phone_number': phoneNumber},
  //     );

  //     // 🔄 Now call API in the background
  //     final result = await authProvider.loginWithPhone(phoneNumber);

  //     if (result != null) {
  //       user.value = result;

  //       // ✅ Save phone number to SharedPreferences
  //       await PreferenceUtils.setPhoneNumber(result.phoneNumber ?? "");
        

  //       // CustomSnackbar.showSnack("Login Successful", "Welcome ${result.name}", true);
  //     } else {
  //       // CustomSnackbar.showSnack("Login Failed", "Invalid phone number", false);
  //     }
  //   } catch (e) {
  //     // CustomSnackbar.showSnack("Login Failed", e.toString(), false);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
