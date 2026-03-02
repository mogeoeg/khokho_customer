// location_api.dart
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:ev/helper/model/city_state_model.dart';
import 'package:ev/utils/preference_utils.dart';

class LocationApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://52.66.201.202/api/v1/location",
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer ${PreferenceUtils.getUserToken()}",
      },
    ),
  );

  Future<List<AddressLocation>> checkLocation({
    String? stateName,
    String? districtCode,
  }) async {
    try {
      final response = await _dio.get(
        "/check_location/",
        queryParameters: {
          "state_name": stateName,
          "district_code": districtCode,
        },
      );

      if (response.data['status'] == true) {
        final List<dynamic> data = response.data['data'];
        return data.map((e) =>AddressLocation.fromJson(e)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      // Handle Dio exceptions
      print("Dio Error: ${e.response?.data ?? e.message}");
      return [];
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
