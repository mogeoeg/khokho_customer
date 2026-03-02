// ignore_for_file: avoid_print

import 'package:ev/common/toast_message.dart';
import 'package:ev/controller/coupon_controller.dart';
import 'package:ev/controller/order_details_controller.dart';
import 'package:ev/controller/payment_method_controller.dart';
import 'package:ev/controller/service_controller.dart';
import 'package:ev/helper/api/create_order_api_service.dart';
import 'package:ev/helper/model/create_order.dart';
import 'package:ev/helper/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class CreateOrderController extends GetxController {
  var isSubmitting = false.obs;

  /// 👇 New method: Handles entire flow

  Future<void> handleSubmitOrder({
    required double? distanceKm,
    required LatLng? pickupLatLng,
  }) async {
    if (isSubmitting.value) {
      print("⏳ Already submitting. Ignoring duplicate tap.");
      return;
    }

    isSubmitting.value = true;

    try {
      final orderController = Get.find<OrderDetailsController>();
      final serviceController = Get.find<ServiceController>();
      final paymentController = Get.find<PaymentMethodController>();
      final couponController = Get.find<CouponController>();

      final selectedService = serviceController.selectedService.value;
      final selectedCoupon = couponController.selectedCoupon.value;
      final selectedPaymentMethodId = paymentController.selectedMethodId.value;

      if (selectedService == null) {
        ToastMessage.show("Please select a service", isSuccess: false);

        return;
      }

      if (pickupLatLng == null) {
        ToastMessage.show("Pickup location not resolved", isSuccess: false);

        return;
      }

      if (selectedPaymentMethodId == -1) {
        ToastMessage.show("Please select a payment method", isSuccess: false);

        return;
      }

      /// ✅ Automatically set payment status based on payment method
      if (selectedPaymentMethodId == 0 || selectedPaymentMethodId == 1) {
        // Card / UPI -> Paid already
        paymentController.setPaymentStatus(1);
      } else if (selectedPaymentMethodId == 2) {
        // Cash / Cash on Delivery -> Pending until driver collects
        paymentController.setPaymentStatus(0);
      } else {
        // Fallback -> mark as pending
        paymentController.setPaymentStatus(0);
      }

      final order = CreateOrderModel(
        fromLocation: orderController.pickupAddress.value,
        destinationLocation: orderController.deliveryAddress.value,
        receiverName: orderController.receiverName.value,
        mail:
            orderController.receiverEmail.value?.isNotEmpty == true
                ? orderController.receiverEmail.value
                : null, // optional
        //  mail: orderController.receiverEmail.value ?? '',
        phoneNumber: orderController.receiverPhone.value,
        services: selectedService.id,
        //    services: selectedService.id is int
        // ? selectedService.id as int
        // : (selectedService.id is double
        //     ? (selectedService.id as double).toInt()
        //     : int.parse(selectedService.id.toString())),
        goodsType: orderController.goodsType.value,
        total: selectedService.totalAmount.toDouble(),
        paymentMethod: selectedPaymentMethodId,
        paymentStatus: paymentController.paymentStatus.value,
        serviceName: selectedService.vehicleType ?? "Unknown",
        distance: distanceKm?.toDouble() ?? 0.0,
        totalTimeTaken: '', // pass empty string if no value yet
        couponId: selectedCoupon?.id,
        couponAmount: selectedCoupon?.couponAmount?.toDouble(),
        longitude: pickupLatLng.longitude.toString(),
        latitude: pickupLatLng.latitude.toString(),
        gTotal:
            (selectedService.totalAmount - (selectedCoupon?.couponAmount ?? 0))
                .toInt(),
        status: 0,

        // fromLocation: orderController.pickupAddress.value,
        // destinationLocation: orderController.deliveryAddress.value,
        // receiverName: orderController.receiverName.value,
        // mail: orderController.receiverEmail.value ?? '',
        // phoneNumber: orderController.receiverPhone.value,
        // services: selectedService.id,
        // goodsType: orderController.goodsType.value,
        // total: selectedService.totalAmount.toDouble(),
        // paymentMethod: selectedPaymentMethodId,
        // paymentStatus: 0,
        // serviceName: selectedService.vehicleType ?? " Unknown",
        // distance: distanceKm ?? 0,
        // totalTimeTaken: '',
        // couponId: selectedCoupon?.id ?? 0,
        // couponAmount: selectedCoupon?.couponAmount?.toDouble() ?? 0,
        // latitude: pickupLatLng.latitude.toString(),
        // longitude: pickupLatLng.longitude.toString(),
        // gTotal:
        //     selectedService.totalAmount -
        //     (selectedCoupon?.couponAmount ?? 0).toDouble(),
        // status: 0,
      );

      /// ✅ Detailed print for debugging
      print("📝 ===== ORDER PAYLOAD =====");
      print("From Location: ${order.fromLocation}");
      print("Destination Location: ${order.destinationLocation}");
      print("Receiver Name: ${order.receiverName}");
      print("Receiver Mail: ${order.mail}");
      print("Receiver Phone: ${order.phoneNumber}");
      print("Service ID: ${order.services}");
      print("Goods Type: ${order.goodsType}");
      print("Total: ${order.total}");
      print("Payment Method: ${order.paymentMethod}");
      print("Payment Status: ${order.paymentStatus}");
      print("Service Name: ${order.serviceName}");
      print("Distance: ${order.distance}");
      print("Total Time Taken: ${order.totalTimeTaken}");
      print("Coupon ID: ${order.couponId}");
      print("Coupon Amount: ${order.couponAmount}");
      print("Latitude: ${order.latitude}");
      print("Longitude: ${order.longitude}");
      print("Grand Total: ${order.gTotal}");
      print("Status: ${order.status}");
      print("============================");

      print('services runtimeType: ${selectedService.id.runtimeType}');
      print('distance runtimeType: ${distanceKm.runtimeType}');

      print("🔍 Order to Submit:");
      print(order.toJson());

      final createdOrder = await OrderApiService.createOrder(order);

      if (createdOrder != null) {
        Get.toNamed(AppRoutes.creatOrderSuccessScreen, arguments: createdOrder);
      } else {
        ToastMessage.show(
          "Unable to create order. Try again",
          isSuccess: false,
        );
      }
    } catch (e) {
      ToastMessage.show("Something went wrong", isSuccess: false);
    } finally {
      isSubmitting.value = false;
    }
  }
}
