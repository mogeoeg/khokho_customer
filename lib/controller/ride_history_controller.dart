// lib/controller/ride_history_controller.dart
// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ev/helper/model/ride_history_model.dart';
import 'package:ev/helper/api/ride_history_api_service.dart';

class RideHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<RideHistoryModel> rides = <RideHistoryModel>[].obs;

  Future<void> loadRideHistory(String fromDate, String toDate) async {
    try {
      isLoading.value = true;
      final result = await RideHistoryApiService.fetchRideHistory(
        fromDate: fromDate,
        toDate: toDate,
      );
      rides.assignAll(result);
    } catch (e) {
      print("❌ Error loading ride history: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
