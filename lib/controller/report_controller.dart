


// ignore_for_file: avoid_print

import 'package:ev/helper/api/report_api_service.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  var isSubmitting = false.obs;
  var errorMessage = ''.obs;

  Future<bool> submitReport({
    required String reason,
    required String comment,
  }) async {
    try {
      print("🟢 ReportController: Submitting report...");
      print("Driver ID: ${PreferenceUtils.getUserId()}");
      print("Reason: $reason");
      print("Comment: $comment");

      isSubmitting.value = true;
      final driverId = PreferenceUtils.getUserId(); // get saved driver id

      final response = await ReportApiService.addReport(
        driverId: driverId,
        reason: reason,
        comment: comment,
      );

      print("📡 API Response: ${response?.message}");
      if (response?.data != null) {
        print("✅ Report created with ID: ${response?.data?.id}");
      }

      if (response != null && response.status) {
        print("✅ Report submission successful");
        return true;
      } else {
        errorMessage.value = response?.message ?? "Failed to submit report";
        print("❌ Report submission failed: ${errorMessage.value}");
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print("🚨 Exception while submitting report: $e");
      return false;
    } finally {
      isSubmitting.value = false;
      print("🔄 ReportController: Finished submitting");
    }
  }
}

