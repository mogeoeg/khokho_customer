// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:ev/helper/model/create_order.dart';
import 'package:ev/helper/model/fetch_order_model.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:http/http.dart' as http;

class OrderApiService {
  static const String _baseUrl =
      'http://52.66.201.202/api/v1/order/create_order/';

  //import 'package:ev/helper/model/fetch_order_model.dart';

  static Future<FetchOrderModel?> createOrder(CreateOrderModel order) async {
    final String token = PreferenceUtils.getUserToken();

    if (token.isEmpty) {
      print("❌ No token found in preferences.");
      return null;
    }

    final uri = Uri.parse(_baseUrl);
    final body = jsonEncode(order.toJson());

    print("🔍 Request Body:");
    print(body);
    print("🔐 Token from PreferenceUtils: $token");

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
      body: body,
    );

    print("📡 Status Code: ${response.statusCode}");
    print("📨 Response Body: ${response.body}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      print("📦 Decoded JSON: $json");

      final orderJson = json['data'];
      if (orderJson is Map<String, dynamic>) {
        return FetchOrderModel.fromJson(orderJson);
      }
      if (orderJson != null && orderJson is Map<String, dynamic>) {
        return FetchOrderModel.fromJson(orderJson);
      } else {
        print("❗ 'data' key missing or invalid");
        return null;
      }
    }
    print("❌ Order API failed or unexpected format: ${response.body}");
    return null;
  }
}
