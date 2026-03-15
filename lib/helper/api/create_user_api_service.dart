// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'package:ev/helper/model/create_user_model.dart';
// import 'package:http/http.dart' as http;

// class UserApiService {
//   Future<bool> updateUser(UpdateUserModel model, int userId, String token) async {
//     final url = Uri.parse('http://4.188.84.32/api/v1/users/update_user/?user_id=$userId');

//     try {
//       final response = await http.patch(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(model.toJson()),
//       );

//       print('Request Body: ${jsonEncode(model.toJson())}');
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       return response.statusCode == 200;
//     } catch (e) {
//       print('Exception: $e');
//       return false;
//     }
//   }
// }

// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:ev/helper/model/create_user_model.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = "http://4.188.84.32/api/v1/users";

  static Future<UserModel?> updateUser({
    required int userId,
    required String name,
    required String companyName,
    required String gstDetails,
    required String email,
    required String phoneNumber,
    required Address address,
    required String location,
    required String mobileToken,
    required bool notificationEnabled,
    required bool isOnline,
    required bool isLocation,
    required bool isCoupen,
    required bool isLoginPermission,
  }) async {
    final url = Uri.parse("$baseUrl/update_user/?user_id=$userId");
    final token = PreferenceUtils.getUserToken();

    final body = {
      "name": name,
      "company_name": companyName,
      "gst_details": gstDetails,
      "email": email,
      "phone_number": phoneNumber,
      "address": address.toJson(),
      "location": location,
      "mobile_token": mobileToken,
      "notification_enabled": notificationEnabled,
      "is_online": isOnline,
      "is_location": isLocation,
      "is_coupen": isCoupen,
      "is_login_permission": isLoginPermission,
    };

    final response = await http.patch(
      url,
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // // final data = jsonDecode(response.body);
      // return UserModel.fromJson(responseData["data"]);

      if (responseData["data"] != null) {
        return UserModel.fromJson(responseData["data"]);
      } else {
        // ✅ Return an empty model or null, but don't throw
        return null;
      }
    } else {
      // Print the exact response for debugging
      print("Update failed! Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      final errorMessage = responseData["message"] ?? "Failed to update user";
      throw Exception(errorMessage);
      // throw Exception("Failed to update user");
    }
  }
}
