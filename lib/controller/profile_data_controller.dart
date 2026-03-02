// // controller/profile_data_controller.dart
// // ignore_for_file: avoid_print

// import 'package:get/get.dart';
// import 'package:ev/utils/PreferenceUtils_utils.dart';

// class ProfileDataController extends GetxController {
//   // Observable fields
//   var name = ''.obs;
//   var email = ''.obs;
//   var phone = ''.obs;
//   var gender = ''.obs;
//   var dob = ''.obs;

//   var companyName = ''.obs;
//   var gst = ''.obs;

//   var addressLine = ''.obs;
//   var city = ''.obs;
//   var state = ''.obs;
//   var nationality = ''.obs;

//   @override
//   void onInit() {
//     fetchProfileData();
//     super.onInit();
//   }

//   void fetchProfileData() {
//     name.value = PreferenceUtilsUtils.getUserName();
//     email.value = PreferenceUtilsUtils.getUserEmail();
//     companyName.value = PreferenceUtilsUtils.getCompanyName();
//     gst.value = PreferenceUtilsUtils.getGstDetails();
//     gst.value = PreferenceUtilsUtils.getPhoneNumber();

//     // If you store other data like phone, DOB, gender etc. add below:
//     // phone.value = PreferenceUtilsUtils.getString('phone');
//     // gender.value = PreferenceUtilsUtils.getString('gender');
//     // dob.value = PreferenceUtilsUtils.getString('dob');

//     addressLine.value = PreferenceUtilsUtils.getAddressLine();
//     city.value = PreferenceUtilsUtils.getCity();
//     state.value = PreferenceUtilsUtils.getState();
//     nationality.value = PreferenceUtilsUtils.getNationality();

//     print('📢 Name: ${name.value}');
//     print('📢 Email: ${email.value}');
//     print('📢 Company: ${companyName.value}');
//     print('📢 GST: ${gst.value}');
//     print('📢 Phone: ${phone.value}');
//     print('📢 Gender: ${gender.value}');
//     print('📢 DOB: ${dob.value}');
//     print('📢 AddressLine: ${addressLine.value}');
//     print('📢 City: ${city.value}');
//     print('📢 State: ${state.value}');
//     print('📢 Nationality: ${nationality.value}');
//   }
// }

// ignore_for_file: avoid_print

// import 'package:ev/utils/preference_utils.dart';
// import 'package:get/get.dart';

// class ProfileDataController extends GetxController {
//   // Observables for user data
//   var userId = 0.obs;
//   var email = ''.obs;
//   var name = ''.obs;
//   var companyName = ''.obs;
//   var gstDetails = ''.obs;
// //  var phoneNumber = ''.obs;

//   // Address info
//   var addressLine = ''.obs;
//   var city = ''.obs;
//   var state = ''.obs;
//   var nationality = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchUserInfo();
//   }

//   /// Fetch login & profile info from PreferenceUtilss
//   void fetchUserInfo() {
//     print("=== Fetching User Info from PreferenceUtilss ===");

//     userId.value = PreferenceUtils.getUserId();
//     email.value = PreferenceUtils.getUserEmail();
//     name.value = PreferenceUtils.getUserName();
//     companyName.value = PreferenceUtils.getCompanyName();
//     gstDetails.value = PreferenceUtils.getGstDetails();
//    // phoneNumber.value = PreferenceUtils.getPhoneNumber();

//     addressLine.value = PreferenceUtils.getAddressLine();
//     city.value = PreferenceUtils.getCity();
//     state.value = PreferenceUtils.getState();
//     nationality.value = PreferenceUtils.getNationality();


    

//     // Debug print for confirmation
//     print("User ID: ${userId.value}");
//     print("Email: ${email.value}");
//     print("Name: ${name.value}");
//     print("Company: ${companyName.value}");
//     print("GST Details: ${gstDetails.value}");
//     //print("Phone: ${phoneNumber.value}");
//     print("Address Line: ${addressLine.value}");
//     print("City: ${city.value}");
//     print("State: ${state.value}");
//     print("Nationality: ${nationality.value}");

//     print("=== User Info Fetch Complete ===");



    
//   }

  
  
// }

import 'package:ev/helper/api/profile_user_info_api_service.dart';
import 'package:ev/helper/model/profile_user_info_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileUserController extends GetxController {
  var user = Rxn<ProfileUserModel>();
  var name = "".obs;
  var email = "".obs;
  var companyName = "".obs;
  var gstDetails = "".obs;
  var addressLine = "".obs;
  var city = "".obs;
  var state = "".obs;
  var nationality = "".obs;

  var isLoading = false.obs;
  var errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final result = await UserApiServiceHttp.getUserByToken();

      if (result != null && result.status && result.data != null) {
        user.value = result;
        final data = result.data!;
        name.value = data.name;
        email.value = data.email;
        companyName.value = data.companyName;
        gstDetails.value = data.gstDetails;
        addressLine.value = data.address?.addressLine ?? "";
        city.value = data.address?.city ?? "";
        state.value = data.address?.state ?? "";
        nationality.value = data.address?.nationality ?? "";
      } else {
        errorMessage.value = result?.message ?? "Failed to fetch user info";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
