// lib/helper/api/ride_history_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ev/helper/model/ride_history_model.dart';
import 'package:ev/utils/preference_utils.dart';

class RideHistoryApiService {
  static const String baseUrl = "http://52.66.201.202/api/v1/driver/ride_history/";

  static Future<List<RideHistoryModel>> fetchRideHistory({
    required String fromDate,
    required String toDate,
  }) async {
    final token = PreferenceUtils.getUserToken();

    final url = Uri.parse("$baseUrl?fromdate=$fromDate&todate=$toDate");
    final response = await http.get(
      url,
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List data = body['data']['all_order_history'];
      return data.map((e) => RideHistoryModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch ride history. Code: ${response.statusCode}");
    }
  }
}
