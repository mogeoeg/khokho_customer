// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:ev/common/toast_message.dart';
import 'package:http/http.dart' as http;
import '../model/login_user_model.dart';

class OtpAuthApiService {
  static const baseUrl = 'http://52.66.201.202/api/v1/users';

  static Future<Map<String, dynamic>> verifyOtp({
    required String otp,
    required String phoneNumber,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/verify_otp/?otp=$otp&phone_number=$phoneNumber',
    );

    final response = await http.post(
      uri,
      headers: {'accept': 'application/json'},
    );
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == true) {
      return {
        'user': LoginUserModel.fromJson(data['data']),
        'access_token': data['access_token'],
        'refresh_token': data['refresh_token'],
      };
    } else {
      print("❌ OTP Verification failed. Message: ${data['message']}");
       ToastMessage.show("OTP Verification Failed. Please check your OTP and try again.", isSuccess: false);
      

      throw Exception('OTP Verification Failed');
    }
  }

  static Future<bool> sendOtpAgain(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user_login/?phone_number=$phoneNumber"),

        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("📨 OTP sent to $phoneNumber");
        return true;
      } else {
        print("❌ Failed to send OTP. Status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🔥 Error sending OTP: $e");
      return false;
    }
  }
}
