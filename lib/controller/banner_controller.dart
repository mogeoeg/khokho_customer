// ignore_for_file: avoid_print

// ✅ CONTROLLER: banner_controller.dart
import 'package:ev/helper/api/banner_api_service.dart';
import 'package:ev/helper/model/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxBool isLoading = false.obs;

  /// ❌ Removed `onInit` fetch

  Future<void> fetchBannerData() async {
    //
    try {
      //isLoading.value = true;
      final result = await BannerApiService.fetchBanners();

      if (result.isNotEmpty) {
        banners.assignAll(result);
        print('✅ Loaded banners: ${result.length}');
      } else {
        print("⚠️ No banners found.");
      }
    } catch (e) {
      print('❌ Banner fetch failed: $e');
    } finally {
      //isLoading.value = false;
    }
  }
}
