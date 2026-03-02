
// // ignore_for_file: avoid_print

// // ✅ API CALL: service_size_api.dart
// import 'dart:convert';
// import 'package:ev/helper/model/service_model.dart';
// import 'package:ev/utils/preference_utils.dart';
// import 'package:http/http.dart' as http;

// class ServiceApi {
//   static const String _baseUrl =
//       'http://52.66.201.202/api/v1/service/get_all_service/?page=1&size=50';

//   static Future<List<ServiceModel>> fetchServices() async {
//     final token = PreferenceUtils.getUserToken();

//     if (token.isEmpty) {
//       print("⚠️ Cannot fetch services. Missing token.");
//       return [];
//     }

//     try {
//       final response = await http.get(
//         Uri.parse(_baseUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );

//       print("📡 Services API Response: ${response.statusCode}");

//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);
//         final List items = decoded['data']?['items'] ?? [];

//         print("✅ Decoded services: ${items.length} items");
//         return items.map((item) => ServiceModel.fromJson(item)).toList();
//       } else {
//         print("❌ Failed to load services. Status: ${response.statusCode}");
//         return [];
//       }
//     } catch (e) {
//       print("🔥 Exception while fetching services: $e");
//       return [];
//     }
//   }
// }








// ignore_for_file: avoid_print

// ✅ API CALL: service_size_api.dart
import 'dart:convert';
import 'package:ev/helper/model/service_model.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  static const String _baseUrl = 'http://52.66.201.202/api/v1/service/get_all_service/';

  static Future<List<ServiceModel>> fetchServices({int page = 1, int size = 50}) async {
    final token = PreferenceUtils.getUserToken();

    if (token.isEmpty) {
      print("⚠️ Cannot fetch services. Missing token.");
      return [];
    }

    try {
      final url = '$_baseUrl?page=$page&size=$size';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("📡 Services API Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List items = decoded['data']?['items'] ?? [];
        return items.map((item) => ServiceModel.fromJson(item)).toList();
      } else {
        print("❌ Failed to load services. Status: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("🔥 Exception while fetching services: $e");
      return [];
    }
  }
}
