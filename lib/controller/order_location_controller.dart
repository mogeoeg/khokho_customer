// controller/order_location_controller.dart
import 'package:ev/utils/preference_utils.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class OrderLocationController extends GetxController {
  var pickupLocation = Rxn<LatLng>();
  var deliveryLocation = Rxn<LatLng>();

  var pickupAddress = ''.obs;
  var deliveryAddress = ''.obs;

  void setPickup(LatLng latLng, String address) {
    pickupLocation.value = latLng;
    pickupAddress.value = address;
  }

  void setDelivery(LatLng latLng, String address) {
    deliveryLocation.value = latLng;
    deliveryAddress.value = address;
  }

  bool get isComplete =>
      pickupLocation.value != null && deliveryLocation.value != null;

  Future<void> saveToPrefs() async {
    if (pickupLocation.value != null && deliveryLocation.value != null) {
      await PreferenceUtils.saveOrderLocation(
        pickupAddress: pickupAddress.value,
        deliveryAddress: deliveryAddress.value,
        pickupLat: pickupLocation.value!.latitude,
        pickupLng: pickupLocation.value!.longitude,
        deliveryLat: deliveryLocation.value!.latitude,
        deliveryLng: deliveryLocation.value!.longitude,
      );
    }
  }

  Future<void> loadFromPrefs() async {
    final data = PreferenceUtils.getOrderLocation();

    pickupAddress.value = data['pickupAddress'];
    deliveryAddress.value = data['deliveryAddress'];

    final pickupLat = data['pickupLat'];
    final pickupLng = data['pickupLng'];
    final deliveryLat = data['deliveryLat'];
    final deliveryLng = data['deliveryLng'];

    if (pickupLat != null && pickupLng != null) {
      pickupLocation.value = LatLng(pickupLat, pickupLng);
    }

    if (deliveryLat != null && deliveryLng != null) {
      deliveryLocation.value = LatLng(deliveryLat, deliveryLng);
    }
  }
}
