 // ignore_for_file: avoid_print

// ✅ API: order_api_service.dart
import 'dart:convert';
import 'package:ev/utils/preference_utils.dart';
import 'package:http/http.dart' as http;
import 'package:ev/helper/model/fetch_order_model.dart';

class FetchOrderApiService {
  static const String _baseUrl =
      'http://4.188.84.32/api/v1/order/get_all_order_by_userid/?page=1&size=50';

  static Future<List<FetchOrderModel>> fetchOrders() async {
    final token = PreferenceUtils.getUserToken();

    if (token.isEmpty) {
      print("❌ No token provided for fetching orders.");
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("📡 Status Code (Fetch Orders): ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List items = jsonResponse['data']?['items'] ?? [];

        print("📦 Orders received: ${items.length}");
        return items.map((json) => FetchOrderModel.fromJson(json)).toList();
      } else {
        print("❌ Failed to load orders: ${response.body}");
        return [];
      }
    } catch (e) {
      print("🔥 Exception in FetchOrderApiService: $e");
      return [];
    }
  }
}
