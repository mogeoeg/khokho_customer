// ignore_for_file: avoid_print

import 'package:ev/helper/api/fetch_order_api_service.dart';
import 'package:ev/utils/preference_utils.dart';
import 'package:get/get.dart';
import 'package:ev/helper/model/fetch_order_model.dart';

class FetchOrderController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<FetchOrderModel> orders = <FetchOrderModel>[].obs;

  /// ❌ Removed onInit fetch (to prevent unwanted API calls before login)

  Future<void> fetchOrders() async {
    print("📦 [FetchOrderController] Fetching orders...");
    isLoading.value = true;

    try {
      final token = PreferenceUtils.getUserToken();
      if (token.isEmpty) {
        print("⚠️ Missing access token.");
        //  CustomSnackbar.showSnack("Error", "Missing user token", false);
        return;
      }

      final result = await FetchOrderApiService.fetchOrders();

      // if (result.isNotEmpty) {
      //   orders.assignAll(result);
      //   print("✅ Orders fetched: ${result.length}");
      // }

      if (result.isNotEmpty) {
  orders.assignAll(result);
  print("✅ Orders fetched: ${result.length}");
  for (var o in result) {
    print("📦 Order ${o.id} → Status: ${o.status} (${o.statusText})");
  }
}  else {
        print("⚠️ No orders returned from server.");
      }
    } catch (e) {
      print("❌ Exception while fetching orders: $e");
      // CustomSnackbar.showSnack("Error", "Failed to fetch orders", false);
    } finally {
       isLoading.value = false;
    }
  }
}
