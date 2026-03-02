// // location_controller.dart
// import 'package:driver_ev/helper/api/city_state_api_service.dart';
// import 'package:driver_ev/helper/model/city_state_model.dart';
// import 'package:flutter/material.dart';

// class CityStateController with ChangeNotifier {
//   final LocationApi _api = LocationApi();
//   List<AddressLocation> _locations = [];
//   bool _isLoading = false;

//   List<AddressLocation> get locations => _locations;
//   bool get isLoading => _isLoading;

//   Future<void> fetchLocations({String? stateName, String? districtCode}) async {
//     _isLoading = true;
//     notifyListeners();

//     _locations = await _api.checkLocation(
//       stateName: stateName,
//       districtCode: districtCode,
//     );

//     _isLoading = false;
//     notifyListeners();
//   }
// }


import 'package:ev/helper/api/city_state_api_service.dart';
import 'package:ev/helper/model/city_state_model.dart';
import 'package:get/get.dart';

class CityStateController extends GetxController {
  final LocationApi _api = LocationApi();

  var locations = <AddressLocation>[].obs; // RxList
  var isLoading = false.obs; // RxBool

  Future<void> fetchLocations({String? stateName, String? districtCode}) async {
    isLoading.value = true;
    try {
      final result = await _api.checkLocation(
        stateName: stateName,
        districtCode: districtCode,
      );
      locations.assignAll(result); // update RxList
    } finally {
      isLoading.value = false;
    }
  }
}
