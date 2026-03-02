// ignore_for_file: avoid_print

import 'package:ev/common/toast_message.dart';
import 'package:ev/helper/api/create_user_api_service.dart';
import 'package:ev/helper/model/create_user_model.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final gstController = TextEditingController();
  //  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressLineController = TextEditingController();
  // final cityController = TextEditingController();
  // final stateController = TextEditingController();
  final nationalityController = TextEditingController();



   // ✅ Use reactive string variables instead of TextEditingController
  var selectedState = ''.obs;
  var selectedCity = ''.obs;

  var isLoading = false.obs;
  var userModel = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    nameController.text = PreferenceUtils.getUserName();
    companyController.text = PreferenceUtils.getCompanyName();
    gstController.text = PreferenceUtils.getGstDetails();
    emailController.text = PreferenceUtils.getUserEmail();


    // ✅ Pre-fill state & city if saved before
    selectedState.value = PreferenceUtils.getState();
    selectedCity.value = PreferenceUtils.getCity();

    // addressLineController.text = PreferenceUtils.getAddressLine();
    // cityController.text = PreferenceUtils.getCity();
    // stateController.text = PreferenceUtils.getState();
    // nationalityController.text = PreferenceUtils.getNationality();
  }

  Future<void> updateUser({bool isEditMode = false}) async {
    if (!formKey.currentState!.validate()) {
      // Get.snackbar("Error", "Please fill all required fields");
      ToastMessage.show("Please fill all required fields", isSuccess: false);
      return;
    }

    isLoading.value = true;
    print("=== Starting Update API Call ===");

    final startTime = DateTime.now();
    try {
      final user = await UserService.updateUser(
        userId: PreferenceUtils.getUserId(),
        name: nameController.text,
        companyName: companyController.text,
        gstDetails: gstController.text,
        email: emailController.text,
        phoneNumber: PreferenceUtils.getUserPhoneNumber(),

        address: Address(
          addressLine: addressLineController.text,
           city: selectedCity.value,
          state: selectedState.value,
          nationality: nationalityController.text,
        ),
        location: "string",
        mobileToken: "string",
        notificationEnabled: true,
        isOnline: true,
        isLocation: true,
        isCoupen: true,
        isLoginPermission: true,
      );

      if (user != null) {
        userModel.value = user;
        // ✅ Save address details in preferences

        await PreferenceUtils.saveUserDetails(
          name: nameController.text,
          companyName: companyController.text,
          gstDetails: gstController.text,
          email: emailController.text,

          //phoneNumber: PreferenceUtils.getUserPhoneNumber(),
        );
        print(
          "Sending phone number from prefs: ${PreferenceUtils.getUserPhoneNumber()}",
        );
        await PreferenceUtils.saveUserAddressDetails(
          addressLine: addressLineController.text,
           city: selectedCity.value,
          state: selectedState.value,
          nationality: nationalityController.text,
        );
        // Get.snackbar("Success", "User updated successfully");

        print("=== Saved to Preferences ===");
        print("Name: ${nameController.text}");
        print("email: ${emailController.text}");
        print("Company: ${companyController.text}");
        print("phone number : ${PreferenceUtils.getUserPhoneNumber()}");

        print("GST: ${gstController.text}");
        print("Address Line: ${addressLineController.text}");
        print("City: ${selectedCity.value}");
        print("State: ${selectedState.value}");
        print("Nationality: ${nationalityController.text}");

        // After address / profile complete
        await PreferenceUtils.setInt('profileStep', 3);

        //  ✅ Navigate to Success Screen
        Get.offNamed(
          AppRoutes.successScreen,
          arguments: {'isEdit': isEditMode},
        );
      }
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      ToastMessage.show("Something went wrong", isSuccess: false);
      print("Update User Error: $message");
    } finally {
      // ⏱ enforce at least 2 seconds loader
      final elapsed = DateTime.now().difference(startTime);
      final remaining = Duration(seconds: 2) - elapsed;

      if (remaining > Duration.zero) {
        await Future.delayed(remaining);
      }

      isLoading.value = false;
      print("=== Update API Call Completed ===");
    }
  }

  // Method for UI button
  void submitProfile() {
    updateUser();
  }
}
