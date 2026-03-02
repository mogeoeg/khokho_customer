// import 'dart:convert';
// import 'package:ev/helper/model/create_user_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:ev/utils/preference_utils.dart';

// class UserApiService {
//   static const String baseUrl = "http://52.66.201.202/api/v1/users";

//   static Future<UserModel?> getUser() async {
//     final token = PreferenceUtils.getUserToken();
//     final url = Uri.parse("$baseUrl/get_user_by_token/");

//     final response = await http.get(
//       url,
//       headers: {
//         "accept": "application/json",
//         "Authorization": "Bearer $token",
//       },
//     );

//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       if (body['status'] == true) {
//         return UserModel.fromJson(body['data']);
//       }
//     }
//     return null;
//   }

//   static Future<bool> updateUser(UserModel user) async {
//     final token = PreferenceUtils.getUserToken();
//     final url = Uri.parse("$baseUrl/update_user/");

//     final response = await http.put(
//       url,
//       headers: {
//         "accept": "application/json",
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $token",
//       },
//       body: jsonEncode(user.toJson()),
//     );

//     return response.statusCode == 200;
//   }
// }



// services/user_api_service_http.dart
import 'dart:convert';
import 'package:ev/helper/model/profile_user_info_model.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:http/http.dart' as http;

class UserApiServiceHttp {
  // Static method to get user by token
  static Future<ProfileUserModel?> getUserByToken() async {
    final token = PreferenceUtils.getUserToken();
    if (token.isEmpty) throw Exception("No token found");

    final url = Uri.parse(
        "http://52.66.201.202/api/v1/users/get_user_by_token/");

    try {
      final response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return ProfileUserModel.fromJson(data);
      } else {
        throw Exception(
            "Failed to fetch user. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching user: $e");
    }
  }
}
