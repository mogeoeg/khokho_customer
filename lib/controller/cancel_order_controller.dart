
import 'package:ev/common/toast_message.dart';
import 'package:ev/controller/fetch_order_controller.dart';
import 'package:ev/helper/api/cancel_order_api_service.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:ev/navigation_menu.dart';
import 'package:get/get.dart';

class CancelOrderController extends GetxController {
  RxBool isCancelling = false.obs;

  Future<void> cancelOrder(int orderId, String token) async {
    isCancelling.value = true;

    try {
      final result = await CancelOrderApiService.cancelOrder(
        orderId: orderId,
        token: token,
      );
      if (result.status) {
        // ✅ Refresh orders
        Get.find<FetchOrderController>().fetchOrders();

        // ✅ Navigate to NavigationMenu and select "My Order"
        Get.offAllNamed(AppRoutes.navigationMenu);

        Get.find<NavigationController>().setTab(1);

 ToastMessage.show("Order has been cancelled successfully.", isSuccess: true);
      


        //  Get.back();
      } else {
         ToastMessage.show("Unable to cancel the order. Please try again.", isSuccess: false);
       

      }
    } catch (e) {
      ToastMessage.show("Something went wrong", isSuccess: false);
     
    } finally {
      isCancelling.value = false;
    }
  }
}
