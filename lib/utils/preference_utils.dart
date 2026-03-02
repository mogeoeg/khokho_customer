import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ev/helper/model/service_model.dart';

class PreferenceUtils {
  static SharedPreferences? _prefsInstance;

  /// Call this once at app startup (e.g., in main.dart)
  static Future<void> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
  }

  // ---------------------- GENERAL GETTERS / SETTERS ----------------------

  static bool getBool(String key) => _prefsInstance?.getBool(key) ?? false;

  static Future<bool> setBool(String key, bool value) async {
    final prefs = _prefsInstance!;
    return prefs.setBool(key, value);
  }

  static String getString(String key) => _prefsInstance?.getString(key) ?? '';

  static Future<bool> setString(String key, String value) async {
    final prefs = _prefsInstance!;
    return prefs.setString(key, value);
  }

  static int getInt(String key) => _prefsInstance?.getInt(key) ?? -1;

  static Future<bool> setInt(String key, int value) async {
    final prefs = _prefsInstance!;
    return prefs.setInt(key, value);
  }

  static double? getDouble(String key) => _prefsInstance?.getDouble(key);

  static Future<bool> setDouble(String key, double value) async {
    final prefs = _prefsInstance!;
    return prefs.setDouble(key, value);
  }

  static Future<void> clearAll() async {
    final prefs = _prefsInstance!;
    await prefs.clear();
  }


  

  // ---------------------- AUTH USER INFO ----------------------

  static Future<void> saveUserToken(String token) async =>
      await setString("access_token", token);

  static Future<void> saveRefreshToken(String token) async =>
      await setString("refresh_token", token);

  static Future<void> saveUserId(int id) async => await setInt("user_id", id);

  static Future<void> saveUserPhoneNumber(String phoneNumber) async =>
      await setString("phone_number", phoneNumber);

  static String getUserToken() => getString("access_token");
  static String getRefreshToken() => getString("refresh_token");
  static String getUserPhoneNumber() => getString("phone_number");
  static int getUserId() => getInt("user_id");



  static Future<void> setIsNewUser(bool value) async =>
      await setBool("is_newUser", value);

  static bool getIsNewUser() => getBool("is_newUser");

  // ---------------------- PROFILE INFO ----------------------

  static Future<void> saveUserDetails({
    String? name,
    String? companyName,
    String? gstDetails,
    String? email,
    String? phoneNumber,
  }) async {
    if (name != null) await setString('name', name);
    if (companyName != null) await setString('company_name', companyName);
    if (gstDetails != null) await setString('gst_details', gstDetails);
        if (email != null) await setString('email', email);
         if (phoneNumber != null) await setString('phone_number', phoneNumber); 
  }

  static String getUserName() => getString("name");
  static String getCompanyName() => getString("company_name");
  static String getGstDetails() => getString("gst_details");
 static String getUserEmail() => getString("email"); // ✅

  static String getPhoneNumber() => getString("phone_number");
  static Future<void> setPhoneNumber(String phoneNumber) async =>
      await setString('phone_number', phoneNumber);

  // static String getGender() => getString("gender");
  // static Future<void> setGender(String gender) async =>
  //     await setString('gender', gender);

  // static String getDob() => getString("dob");
  // static Future<void> setDob(String dob) async => await setString('dob', dob);






// ---------------------- SAVE FULL PROFILE ----------------------

  static Future<void> saveUserProfileData({
    required int userId,
    required String token,
    required String email,
    String? name,
    String? companyName,
    String? gstDetails,
  String? phoneNumber,  
  }) async {
    await saveUserId(userId);
    await saveUserToken(token);
    
   // await saveUserPhoneNumber(phoneNumber);
    await saveUserDetails(
      name: name,
      companyName: companyName,
      gstDetails: gstDetails,
      phoneNumber: phoneNumber, 
    );
     if (phoneNumber != null) {
    await saveUserPhoneNumber(phoneNumber); // ✅ only if not null
  }
  }

  // ---------------------- ADDRESS DETAILS ----------------------

  // At the bottom of PreferenceUtils (under profile section)

 

  // --------- SAVE METHODS ---------
 
  static Future<void> saveUserAddressDetails({
    required String addressLine,
    required String city,
    required String state,
    required String nationality,
  }) async {
    await _prefsInstance?.setString("addressLine", addressLine);
    await _prefsInstance?.setString("city", city);
    await _prefsInstance?.setString("state", state);
    await _prefsInstance?.setString("nationality", nationality);
  }

  // --------- GET METHODS ---------

  static String getAddressLine() =>
      _prefsInstance?.getString("addressLine") ?? "Not Available";

  static String getCity() =>
  _prefsInstance?.getString("city") ?? "Not Available";

  static String getState() =>
      _prefsInstance?.getString("state") ?? "Not Available";

  static String getNationality() =>
      _prefsInstance?.getString("nationality") ?? "Not Available";


  // static Future<void> saveUserAddressDetails({
  //   required String addressLine,
  //   required String city,
  //   required String state,
  //   required String nationality,
  // }) async {
  //   await setString('address_line', addressLine);
  //   await setString('city', city);
  //   await setString('state', state);
  //   await setString('nationality', nationality);
  // }

  // static String getAddressLine() => getString('address_line');
  // static String getCity() => getString('city');
  // static String getState() => getString('state');
  // static String getNationality() => getString('nationality');

  // ---------------------- ORDER DETAILS ----------------------

  static Future<void> saveOrderDetails({
    required String pickupAddress,
    required String deliveryAddress,
    required String pickupLatitude,
    required String pickupLongitude,
    required String goodsType,
    required String selectedService,
    required int selectedServiceId,
    required String receiverName,
    required String receiverPhone,
    String? receiverEmail,
  }) async {
    await setString('pickupAddress', pickupAddress);
    await setString('deliveryAddress', deliveryAddress);
    await setString('pickupLatitude', pickupLatitude);
    await setString('pickupLongitude', pickupLongitude);
    await setString('goodsType', goodsType);
    await setString('selectedService', selectedService);
    await setInt('selectedServiceId', selectedServiceId);
    await setString('receiverName', receiverName);
    await setString('receiverPhone', receiverPhone);

    if (receiverEmail != null) {
      await setString('receiverEmail', receiverEmail);
    } else {
      _prefsInstance?.remove('receiverEmail');
    }
  }

  static Map<String, dynamic> getOrderDetails() {
    return {
      'pickupAddress': getString('pickupAddress'),
      'deliveryAddress': getString('deliveryAddress'),
      'pickupLatitude': getString('pickupLatitude'),
      'pickupLongitude': getString('pickupLongitude'),
      'goodsType': getString('goodsType'),
      'selectedService': getString('selectedService'),
      'selectedServiceId': getInt('selectedServiceId'),
      'receiverName': getString('receiverName'),
      'receiverPhone': getString('receiverPhone'),
      'receiverEmail': _prefsInstance?.getString('receiverEmail'), // nullable
    };
  }

  // ---------------------- ORDER LOCATION ----------------------

  static Future<void> saveOrderLocation({
    required String pickupAddress,
    required String deliveryAddress,
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
  }) async {
    await setString('pickupAddress', pickupAddress);
    await setString('deliveryAddress', deliveryAddress);
    await setDouble('pickupLat', pickupLat);
    await setDouble('pickupLng', pickupLng);
    await setDouble('deliveryLat', deliveryLat);
    await setDouble('deliveryLng', deliveryLng);
  }

  static Map<String, dynamic> getOrderLocation() {
    return {
      'pickupAddress': getString('pickupAddress'),
      'deliveryAddress': getString('deliveryAddress'),
      'pickupLat': getDouble('pickupLat'),
      'pickupLng': getDouble('pickupLng'),
      'deliveryLat': getDouble('deliveryLat'),
      'deliveryLng': getDouble('deliveryLng'),
    };
  }


//_______________________Selected service _______________________

  // ✅ In PreferenceUtils
static Future<void> saveSelectedService(ServiceModel service) async {
  await setInt('selectedServiceId', service.id);
  await setString('selectedServiceName', service.vehicleType ?? 'Unknown');
  await setDouble('selectedServicePrice', service.totalAmount);
}

static Map<String, dynamic> getSelectedService() {
  return {
    'id': getInt('selectedServiceId'),
    'name': getString('selectedServiceName'),
    'price': getDouble('selectedServicePrice'),
  };
}

}
