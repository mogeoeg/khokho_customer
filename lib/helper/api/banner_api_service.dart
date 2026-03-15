

// ignore_for_file: avoid_print

// ✅ API: banner_api_service.dart
import 'dart:convert';
import 'package:ev/helper/model/banner_model.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:http/http.dart' as http;

class BannerApiService {
  static const _url = 'http://4.188.84.32/api/v1/banners/get_banner/';

  static Future<List<BannerModel>> fetchBanners() async {
    final token = PreferenceUtils.getUserToken();

    if (token.isEmpty) {
      print("⚠️ Missing user token");
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('📡 Banner API Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List data = decoded['data'] ?? [];

        print('📦 Banner items: ${data.length}');
        return data.map((e) => BannerModel.fromJson(e)).toList();
      } else {
        print('❌ Failed to load banners. Status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print("🔥 Banner API exception: $e");
      return [];
    }
  }
}
