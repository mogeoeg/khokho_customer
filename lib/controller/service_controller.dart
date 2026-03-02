// // ignore_for_file: avoid_print

// // ✅ CONTROLLER: service_controller.dart
// import 'package:ev/common/snackbar.dart';
// import 'package:ev/helper/api/service_size_api.dart';
// import 'package:ev/helper/model/service_model.dart';
// import 'package:get/get.dart';

// class ServiceController extends GetxController {
//   RxList<ServiceModel> services = <ServiceModel>[].obs;
//   RxBool isLoading = false.obs;

//   Rx<ServiceModel?> selectedService = Rx<ServiceModel?>(null);

//   // ❌ Removed onInit fetch

//   /// ✅ Call this *after login*, not automatically
//   Future<void> fetchAllServices() async {
//     isLoading.value = true;
//     try {
//       final data = await ServiceApi.fetchServices();

//       if (data.isNotEmpty) {
//         services.assignAll(data);
//         print("✅ Services fetched: ${data.length}");
//       } else {
//         print("⚠️ No services found.");
//       }
//     } catch (e) {
//       print("❌ Error in fetchAllServices: $e");
//       CustomSnackbar.showSnack('Error', 'Failed to fetch services', false);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void setSelectedService(ServiceModel service) {
//     selectedService.value = service;
//   }

//   void clearSelectedService() {
//     selectedService.value = null;
//   }
// }




// ignore_for_file: avoid_print

// ✅ CONTROLLER: service_controller.dart
import 'package:ev/common/toast_message.dart';
import 'package:ev/helper/api/service_size_api.dart';
import 'package:ev/helper/model/service_model.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController {
  RxList<ServiceModel> services = <ServiceModel>[].obs;
  RxBool isLoading = false.obs;
  Rx<ServiceModel?> selectedService = Rx<ServiceModel?>(null);

  Future<void> fetchAllServices({int page = 1, int size = 50}) async {
    isLoading.value = true;
    try {
      final data = await ServiceApi.fetchServices(page: page, size: size);

      if (data.isNotEmpty) {
        services.assignAll(data);
        print("✅ Services fetched: ${data.length}");
      } else {
        print("⚠️ No services found.");
      }
    } catch (e) {
      print("❌ Error in fetchAllServices: $e");
      ToastMessage.show("Failed to fetch services", isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedService(ServiceModel service) {
    selectedService.value = service;
  }

  void clearSelectedService() {
    selectedService.value = null;
  }
}



