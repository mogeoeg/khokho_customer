import 'dart:convert';
import 'package:ev/helper/model/report_model.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:http/http.dart' as http;

class ReportApiService {
  static const String _baseUrl =
      "http://13.235.24.96:8000/api/v1/report/add_report";

  static Future<ReportResponse?> addReport({
    required int driverId,
    required String reason,
    required String comment,
  }) async {
    try {
      final token = PreferenceUtils.getUserToken(); // get your saved token

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "driver_id": driverId,
          "reason": reason,
          "comment": comment,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return ReportResponse.fromJson(json);
      } else {
        throw Exception("Failed to submit report: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
