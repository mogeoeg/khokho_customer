import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ev/helper/model/cancel_order_model.dart';

class CancelOrderApiService {
  static const String baseUrl = 'http://4.188.84.32/api/v1/order';

  static Future<CancelOrderResponse> cancelOrder({
    required int orderId,
    required String token,
  }) async {
    final uri = Uri.parse('$baseUrl/cancel_order/?orderid=$orderId');

    final response = await http.patch(
      uri,
      headers: {'accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CancelOrderResponse.fromJson(data);
    } else {
      throw Exception("Failed to cancel order");
    }
  }
}
