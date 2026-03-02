import 'package:ev/controller/banner_controller.dart';
import 'package:ev/controller/cancel_order_controller.dart';
import 'package:ev/controller/coupon_controller.dart';
import 'package:ev/controller/create_order_controller.dart';
import 'package:ev/controller/fetch_order_controller.dart';
import 'package:ev/controller/image_picker_controller.dart';
import 'package:ev/controller/order_details_controller.dart';
import 'package:ev/controller/order_location_controller.dart';
import 'package:ev/controller/payment_method_controller.dart';
import 'package:ev/controller/profile_creation_controller.dart';
import 'package:ev/controller/company_details.controller.dart';
import 'package:ev/controller/help_controller.dart';
import 'package:ev/controller/login_controller.dart';
import 'package:ev/controller/profile_data_controller.dart';
import 'package:ev/controller/report_controller.dart';
import 'package:ev/controller/ride_history_controller.dart';
import 'package:ev/controller/service_controller.dart';
import 'package:ev/navigation_menu.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    /// ✅ Global navigation state (kept alive forever)
    Get.put<NavigationController>(NavigationController());

    /// ✅ Lazy load everything else, auto-recreate if disposed
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => LoginAuthController(), fenix: true);
    Get.lazyPut(() => CompanyDetailsController(), fenix: true);
    Get.lazyPut(() => HelpController(), fenix: true);
    Get.lazyPut(() => OrderLocationController(), fenix: true);
    Get.lazyPut(() => ServiceController(), fenix: true);
    Get.lazyPut(() => OrderDetailsController(), fenix: true);
    Get.lazyPut(() => CouponController(), fenix: true);
    Get.lazyPut(() => PaymentMethodController(), fenix: true);
    Get.lazyPut(() => CreateOrderController(), fenix: true);
    Get.lazyPut(() => FetchOrderController(), fenix: true);
    Get.lazyPut(() => BannerController(), fenix: true);
    Get.lazyPut(() => CancelOrderController(), fenix: true);
    Get.lazyPut(() => ImagePickerController(), fenix: true);
    Get.lazyPut(() => ProfileUserController(), fenix: true);
    Get.lazyPut(() => RideHistoryController(), fenix: true);
    Get.lazyPut(() => ReportController(), fenix: true);
  }
}
