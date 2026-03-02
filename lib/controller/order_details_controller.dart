// ignore_for_file: avoid_print

import 'package:ev/utils/preference_utils.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class OrderDetailsController extends GetxController {
  // Location Details
  final pickupAddress = ''.obs;
  final deliveryAddress = ''.obs;
  final pickupLatitude = ''.obs;
  final pickupLongitude = ''.obs;
   RxDouble distanceKm = 0.0.obs;
  Rx<LatLng?> pickupLatLng = Rx<LatLng?>(null);
  Rx<LatLng?> dropLatLng = Rx<LatLng?>(null);

  // Package Details
  final goodsType = ''.obs;
  final selectedService = ''.obs; // ✅ for UI/display
  final selectedServiceId = RxInt(0); // ✅ for backend API

  // Receiver Details
  final receiverName = ''.obs;
  final receiverPhone = ''.obs;
  final RxnString receiverEmail = RxnString(); // ✅ nullable string


  /// Save to SharedPreferences
  Future<void> saveToPrefs() async {
    await PreferenceUtils.saveOrderDetails(
      pickupAddress: pickupAddress.value,
      deliveryAddress: deliveryAddress.value,
      pickupLatitude: pickupLatitude.value,
      pickupLongitude: pickupLongitude.value,
      goodsType: goodsType.value,
      selectedService: selectedService.value,
      selectedServiceId: selectedServiceId.value,
      receiverName: receiverName.value,
      receiverPhone: receiverPhone.value,
      receiverEmail: receiverEmail.value,
    );

    print('✅ Order details saved via PreferenceUtils');
    print('Pickup: ${pickupAddress.value}');
    print('Pickup Lat: ${pickupLatitude.value}');
    print('Pickup Lng: ${pickupLongitude.value}');
    print('Delivery: ${deliveryAddress.value}');
    print('Goods Type: ${goodsType.value}');
    print('Service ID: ${selectedServiceId.value}');
    print('Service Name: ${selectedService.value}');
    print('Receiver Name: ${receiverName.value}');
    print('Receiver Phone: ${receiverPhone.value}');
    print('Receiver Email: ${receiverEmail.value}');
  }

  /// Load from SharedPreferences (optional usage)
  Future<void> loadFromPrefs() async {
    final data = PreferenceUtils.getOrderDetails();

    pickupAddress.value = data['pickupAddress'];
    deliveryAddress.value = data['deliveryAddress'];
    pickupLatitude.value = data['pickupLatitude'];
    pickupLongitude.value = data['pickupLongitude'];
    goodsType.value = data['goodsType'];
    selectedService.value = data['selectedService'];
    selectedServiceId.value = data['selectedServiceId'];
    receiverName.value = data['receiverName'];
    receiverPhone.value = data['receiverPhone'];
    receiverEmail.value = data['receiverEmail'];
  }


  /// Clear all order details (start fresh)
  void clearAllOrderDetails() {
    pickupAddress.value = '';
    deliveryAddress.value = '';
    pickupLatitude.value = '';
    pickupLongitude.value = '';
    goodsType.value = '';
    selectedService.value = '';
    selectedServiceId.value = 0;
    receiverName.value = '';
    receiverPhone.value = '';
    receiverEmail.value = null;
    pickupLatLng.value = null;
    dropLatLng.value = null;

    print('🧹 Cleared all order details');
  }




}
