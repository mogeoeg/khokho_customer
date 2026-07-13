// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:ev/helper/model/coupon_model.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:http/http.dart' as http;

class CouponService {
  static const String baseUrl =
      "http://13.235.24.96:8000/api/v1/coupen/get_all_coupen/?page=1&size=50";
  // static const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwiZXhwIjoxNzg0NTUxMjM5fQ.HC7PeyVsNlcCW6annNHzFCknZbD5Oi94EjqcHUMKnWE";

  static Future<List<CouponModel>> fetchCoupons() async {
    final token = PreferenceUtils.getUserToken();
    if (token.isEmpty) {
      print("❌ Missing access token");
    }

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // Add this for debugging
        print("Decoded JSON: $decoded");

        final List data = decoded['data']?['items'] ?? [];

        return data.map((json) => CouponModel.fromJson(json)).toList();
      } else {
        print("Failed to load coupons");
        return [];
      }
    } catch (e) {
      print("🔥 Exception in fetchCoupons: $e");
      return [];
    }
  }
}
