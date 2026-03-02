// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'package:ev/helper/model/login_user_model.dart';
// import 'package:http/http.dart' as http;

// class LoginAuthProvider {
//   final String baseUrl = 'http://52.66.201.202';

//   Future<LoginUserModel?> loginWithEmail(String email) async {
//     final url = Uri.parse('$baseUrl/api/v1/users/user_login/?email=$email');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'accept': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['status'] == true) {
//           return LoginUserModel.fromJson(json['data']);
//         } else {
//           print("⚠️ Login failed: ${json['message']}");
//           return null;
//         }
//       } else {
//         print("⚠️ Login failed: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("❌ Exception during login: $e");
//       return null;
//     }
//   }
// }




// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:ev/helper/model/login_user_model.dart';
import 'package:http/http.dart' as http;

class LoginAuthProvider {
  final String baseUrl = 'http://52.66.201.202';

  Future<LoginUserModel?> loginWithPhone(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/api/v1/users/user_login/?phone_number=$phoneNumber');

    try {
      final response = await http.post(
        url,
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == true) {
          return LoginUserModel.fromJson(json['data']);
        } else {
          print("⚠️ Login failed: ${json['message']}");
          return null;
        }
      } else {
        print("⚠️ Login failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception during login: $e");
      return null;
    }
  }
}
