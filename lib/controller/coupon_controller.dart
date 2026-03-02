

// ignore_for_file: avoid_print

import 'package:ev/helper/api/coupon_api_service.dart';
import 'package:ev/helper/model/coupon_model.dart';
import 'package:get/get.dart';

class CouponController extends GetxController {
  var coupons = <CouponModel>[].obs;
  var isLoading = false.obs;
  Rxn<CouponModel> selectedCoupon = Rxn<CouponModel>();

  // ❌ No onInit fetch

  /// ✅ Call this manually *after* login and token is saved
  Future<void> fetchCoupons() async {
    isLoading(true);
    try {
      final result = await CouponService.fetchCoupons();

      if (result.isNotEmpty) {
        coupons.assignAll(result);
        print("✅ Coupons fetched: ${result.length}");
      } else {
        print("⚠️ No coupons found.");
      }
    } catch (e) {
      print("❌ Error fetching coupons: $e");
      //CustomSnackbar.showSnack('Error', 'Failed to fetch coupons', false);
    } finally {
      isLoading(false);
    }
  }

  void applyCoupon(CouponModel coupon) {
    selectedCoupon.value = coupon;
  }

  void clearCoupon() {
    selectedCoupon.value = null;
  }
}
