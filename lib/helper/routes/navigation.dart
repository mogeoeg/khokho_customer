import 'package:ev/common/create_order_success_screen.dart';
import 'package:ev/common/success_screen.dart';
import 'package:ev/controller/otp_controller.dart';
import 'package:ev/navigation_menu.dart';
import 'package:ev/view/auth/address/address_details_screen.dart';
import 'package:ev/view/auth/company_details/company_details_screen.dart';
import 'package:ev/view/auth/otp_verification/otp_screen.dart';
import 'package:ev/view/check_rates/check_rates_screen.dart';
import 'package:ev/view/coupon_screen/coupon_screen.dart';
import 'package:ev/view/help_center/help_center_screen.dart';
import 'package:ev/view/my_order/final_track_screen.dart';
import 'package:ev/view/order_booking/book_order_screen.dart';
import 'package:ev/view/order_package_details/entry_location_for_create_order_screen.dart';
import 'package:ev/view/order_package_details/package_details.dart';
import 'package:ev/view/payment_method_screen/payment_method_screen.dart';
import 'package:ev/view/profile/edit_form_info_screen.dart';
import 'package:ev/view/profile/view_profile_screen.dart';
import 'package:ev/view/profile/privacy_policy_screen.dart';
import 'package:ev/view/profile/terms_condition_screen.dart';
import 'package:ev/view/report/report_screen.dart';
import 'package:get/get.dart';

abstract class AppRoutes {
  static const loginScreen = '/login';
  static const otpScreen = '/otp';
  static const companyDetailScreen = '/company';
  static const addressDetailsScreen = '/address';
  static const successScreen = '/success';
  static const navigationMenu = '/home';
  static const notification = '/notification';
  static const createOrderLocaitonEntry = '/location-entry';
  static const coupon = '/coupon-screen';
  static const paymentMethod = '/payment-method';
  static const packageDetails = '/package-details';
  static const trackOrder = '/track-order';
  static const bookOrder = '/book-order';
  static const creatOrderSuccessScreen = '/success-screen';
  static const helpCenter = '/help-center';
  static const checkRates = '/check-rates';
  static const receiverInfo = '/receiver-info';
  static const editProfileInfoScreen = '/edit-profile';
  static const viewProfileDetailsScreen = '/view-profile';
  static const termsAndConditionScreen = '/terms-condition';
  static const privacyPolicyScreen = '/privacy-policy';
  static const orderStatus = '/order-status';
  static const reportScreen = '/report';

  static final routes = [
    GetPage(name: reportScreen, page: () => ReportScreen()),

    //  GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: companyDetailScreen, page: () => CompanyDetailsScreen()),
    GetPage(name: addressDetailsScreen, page: () => AddressDetails()),
    GetPage(name: navigationMenu, page: () => NavigationMenu()),
    GetPage(name: privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
    GetPage(name: bookOrder, page: () => BookingOrderScreen()),
    GetPage(name: receiverInfo, page: () => TReceiverScreen()),
    GetPage(name: coupon, page: () => TCouponContainer()),
    GetPage(name: paymentMethod, page: () => PaymentMethodScreen()),
    GetPage(name: checkRates, page: () => CheckRatesScreen()),
    GetPage(name: orderStatus, page: () => OrderStatusScreen()),
    GetPage(name: helpCenter, page: () => HelpCenterScreen()),
    GetPage(name: viewProfileDetailsScreen, page: () => ProfileDetailsScreen()),
    GetPage(name: editProfileInfoScreen, page: () => EditProfileScreen()),
    GetPage(
      name: termsAndConditionScreen,
      page: () => TermsAndConditionsScreen(),
    ),
    GetPage(name: otpScreen, page: () => OtpScreen(), binding: OtpBinding()),
    GetPage(
      name: creatOrderSuccessScreen,
      page: () => OrderCreateSuccessScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: successScreen,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
      page: () => SuccessScreen(),
    ),
    GetPage(
      name: createOrderLocaitonEntry,
      page: () => CreateOrderLocationEntryScreen(),
    ),
  ];
}

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpController());
  }
}
