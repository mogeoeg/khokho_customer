

// ignore_for_file: avoid_print

import 'dart:async';
import 'package:ev/common/toast_message.dart';
import 'package:ev/helper/api/otp_api_service.dart';
import 'package:ev/helper/api/profile_user_info_api_service.dart';
import 'package:ev/helper/model/login_user_model.dart';
import 'package:ev/helper/model/profile_user_info_model.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/routes/navigation.dart';

class OtpController extends GetxController {
  final phoneNumber = ''.obs;
  final otpValue = ''.obs;
  final isLoading = false.obs;
  final isResending = false.obs;
  final secondsRemaining = 30.obs;

  Timer? _timer;
  final hiddenController = TextEditingController();

  bool get isOtpComplete => otpValue.value.length == 6;

  @override
  void onInit() {
    super.onInit();

    debugPrint("🔍 OtpController initialized...");
    _startTimer();

    final args = Get.arguments;
    if (args != null && args is Map && args['phone_number'] != null) {
      phoneNumber.value = args['phone_number'];
      debugPrint("📱 Phone number detected: ${phoneNumber.value}");
    } else {
      debugPrint("⚠️ No phone number found in arguments!");
    }
  }

  Future<void> submitOtp() async {
    final otp = otpValue.value.trim();
    debugPrint("📤 Submitting OTP: $otp");

    if (otp.length < 6) {
      ToastMessage.show("Enter a valid 6-digit OTP", isSuccess: false);
      return;
    }

    if (phoneNumber.value.isEmpty) {
      ToastMessage.show(
        "Phone number not found. Cannot verify OTP.",
        isSuccess: false,
      );
      return;
    }

    try {
      isLoading.value = true;
      debugPrint("⏳ Verifying OTP with API...");
      final result = await OtpAuthApiService.verifyOtp(
        otp: otp,
        phoneNumber: phoneNumber.value,
      );

      // Parse response safely
      final user = result['user'] as LoginUserModel;

      final token = result['access_token'];
      final refreshToken = result['refresh_token'];

      debugPrint("✅ OTP verified. Saving user session...");
      await PreferenceUtils.saveUserId(user.id ?? -1);
      await PreferenceUtils.saveUserToken(token);
      await PreferenceUtils.saveRefreshToken(refreshToken);
      await PreferenceUtils.saveUserPhoneNumber(phoneNumber.value);
      // 🔄 Fetch full driver profile (guarantees latest name/vehicle/docs)
      final profile = await UserApiServiceHttp.getUserByToken();

      //  if (profile != null) {
      // // Save driver info to preferences (like you do in DriverController)
      // await PreferenceUtils.saveName(profile.name);
      // await PreferenceUtils.saveVehicleNumber(profile.vehicleNumber ?? '');
      // await PreferenceUtils.saveLicenseLink(profile.licenseLink ?? '');
      // await PreferenceUtils.saveAadhaarLink(profile.aadhaarLink ?? '');
      // await PreferenceUtils.saveProfileImageLink(profile.profilePic ?? '');

      if (profile != null) {
        await PreferenceUtils.saveUserDetails(
          name: user.name,
          companyName: user.companyName,
          gstDetails: user.gstDetails,
          email: user.email,
        );
      }
      // ✅ Only save address if it exists
      if (user.address != null) {
        await PreferenceUtils.saveUserAddressDetails(
          addressLine: user.address?.addressLine ?? '',
          city: user.address?.city ?? '',
          state: user.address?.state ?? '',
          nationality: user.address?.nationality ?? '',
        );
      } else {
        debugPrint("📭 No address found → Skipping saveUserAddressDetails");
      }

      // if (profile != null) {
      //   await PreferenceUtils.saveUserAddressDetails(
      //     addressLine: user.address!.addressLine,
      //     city: user.address!.city,
      //     state: user.address!.state,
      //     nationality: user.address!.nationality,
      //   );
      // }

      //  bool _isNewUser(LoginUserModel user) {
      //     // Check directly from API response instead of PreferenceUtils
      //     return (user.name == null || user.name!.isEmpty) &&
      //         (user.companyName == null || user.companyName!.isEmpty) &&
      //         (user.gstDetails == null || user.gstDetails!.isEmpty);
      //   }

      final userData = profile?.data;

      final isNewUser =
          (userData?.name.isEmpty ?? true) &&
          (userData?.companyName.isEmpty ?? true) &&
          (userData?.gstDetails.isEmpty ?? true);

      await PreferenceUtils.setIsNewUser(isNewUser);

      debugPrint("🧾 Profile Name: ${userData?.name}");
      debugPrint("🧾 ComPany Name: ${userData?.companyName}");
      debugPrint("🧾 Gst Details: ${userData?.gstDetails}");
        debugPrint("🆕 isNewUser: $isNewUser");

      // Navigate based on new or existing user

       if (profile != null && _isNewUser(profile)) {
        debugPrint("🆕 New user detected → Navigate to CompanyDetailScreen");
        Get.offNamed(AppRoutes.companyDetailScreen);
      } else {
        debugPrint("🏠 Existing user → Navigate to HomeScreen");
        Get.offAllNamed(AppRoutes.navigationMenu);
      }
      // if (_isNewUser(profile!)) {
      //   debugPrint("🆕 New user detected → Navigate to CompanyDetailScreen");
      //   Get.offNamed(AppRoutes.companyDetailScreen);
      // } else {
      //   debugPrint("🏠 Existing user → Navigate to HomeScreen");
      //   Get.offAllNamed(AppRoutes.navigationMenu);
      // }
    } catch (e) {
      debugPrint("❌ OTP verification failed: $e");
      ToastMessage.show("OTP verification failed.", isSuccess: false);
    } finally {
      isLoading.value = false;
      debugPrint("✅ OTP verification process finished");
    }
  }

  void resendOtp() async {
    if (phoneNumber.value.isEmpty) {
      debugPrint("❌ Cannot resend OTP, phone number is empty");
      return;
    }

    try {
      debugPrint("🔁 Resending OTP...");
      isResending.value = true;
      final isSuccess = await OtpAuthApiService.sendOtpAgain(phoneNumber.value);
      if (isSuccess) {
        debugPrint("✅ OTP sent again successfully");
        ToastMessage.show("OTP sent again", isSuccess: true);
        _startTimer();
      } else {
        debugPrint("❌ Failed to resend OTP");
        ToastMessage.show("Failed to send OTP.", isSuccess: false);
      }
    } catch (e) {
      debugPrint("❌ Exception while resending OTP: $e");
      ToastMessage.show("Failed to send OTP.", isSuccess: false);
    } finally {
      isResending.value = false;
    }
  }

    bool _isNewUser(ProfileUserModel profile) {
    final data = profile.data;
    return (data?.name.isEmpty ?? true) &&
        (data?.companyName.isEmpty ?? true) &&
        (data?.gstDetails.isEmpty ?? true);
  }

  // bool _isNewUser(LoginUserModel user) {
  //   // Check directly from API response instead of PreferenceUtils
  //   return (user.name == null || user.name!.isEmpty) &&
  //       (user.companyName == null || user.companyName!.isEmpty) &&
  //       (user.gstDetails == null || user.gstDetails!.isEmpty);
  // }

  void updateOtpValue(String value) {
    otpValue.value = value;
    debugPrint("🔹 Current OTP value updated: $value");
  }

  void _startTimer() {
    secondsRemaining.value = 30;
    _timer?.cancel();
    debugPrint("⏱️ Starting 30s countdown timer...");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
        debugPrint("⏳ OTP timer expired");
      }
    });
  }

  @override
  void onClose() {
    debugPrint("🧹 Cleaning up OtpController...");
    _timer?.cancel();
    // stop SMS listener from sms_autofill
    hiddenController.dispose();
    super.onClose();
  }
}
