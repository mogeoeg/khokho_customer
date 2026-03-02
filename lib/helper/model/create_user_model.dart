// class Address {
//   String addressLine;
//   String city;
//   String state;
//   String nationality;

//   Address({
//     required this.addressLine,
//     required this.city,
//     required this.state,
//     required this.nationality,
//   });

//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       addressLine: json['address_line'] ?? '',
//       city: json['city'] ?? '',
//       state: json['state'] ?? '',
//       nationality: json['nationality'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "address_line": addressLine,
//         "city": city,
//         "state": state,
//         "nationality": nationality,
//       };
// }

// class UpdateUserModel {
//   String name;
//   String companyName;
//   String gstDetails;
// //  String email;
//   String? phoneNumber;
//   Address address;
//   String? location;
//   String? mobileToken;
//   bool? notificationEnabled;
//   bool? isOnline;
//   bool? isLocation;
//   bool? isCoupen;
//   bool isLoginPermission;

//   UpdateUserModel({
//     required this.name,
//     required this.companyName,
//     required this.gstDetails,
//     //required this.email,
//     this.phoneNumber,
//     required this.address,
//     this.location,
//     this.mobileToken,
//     this.notificationEnabled,
//     this.isOnline,
//     this.isLocation,
//     this.isCoupen,
//     required this.isLoginPermission,
//   });

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "company_name": companyName,
//         "gst_details": gstDetails,
//         //"email": email,
//         "phone_number": phoneNumber,
//         "address": address.toJson(),
//         "location": location,
//         "mobile_token": mobileToken,
//         "notification_enabled": notificationEnabled,
//         "is_online": isOnline,
//         "is_location": isLocation,
//         "is_coupen": isCoupen,
//         "is_login_permission": isLoginPermission,
//       };
// }

class Address {
  String addressLine;
  String city;
  String state;
  String nationality;

  Address({
    required this.addressLine,
    required this.city,
    required this.state,
    required this.nationality,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine: json["address_line"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      nationality: json["nationality"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address_line": addressLine,
      "city": city,
      "state": state,
      "nationality": nationality,
    };
  }
}

class UserModel {
  int id;
  String name;
  String companyName;
  String gstDetails;
  String phoneNumber;
  String email;
  Address address;
  bool notificationEnabled;
  bool isOnline;
  bool isLocation;
  bool isCoupen;
  bool isLoginPermission;
  String location;
  String mobileToken;

  // ✅ Extra fields from Swagger
//  String? phoneNumber;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool isGstVerified;
  String? otp;
  bool isDeleted;

  UserModel({
    required this.id,
    required this.name,
    required this.companyName,
    required this.gstDetails,
    // required this.phoneNumber,
     required this.email,
    required this.address,
    required this.notificationEnabled,
    required this.isOnline,
    required this.isLocation,
    required this.isCoupen,
    required this.isLoginPermission,
    required this.location,
    required this.mobileToken,
    required this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isGstVerified = false,
    this.otp,
    this.isDeleted = false,
  });


Map<String, dynamic> toJson() {
  return {
    "name": name,
    "company_name": companyName,
    "gst_details": gstDetails,
    "email": email,
    "phone_number": phoneNumber,
    "address": address.toJson(),
    "location": location,
    "mobile_token": mobileToken,
    "notification_enabled": notificationEnabled,
    "is_online": isOnline,
    "is_location": isLocation,
    "is_coupen": isCoupen,
    "is_login_permission": isLoginPermission,
  };
}

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0, // ✅ fallback to 0 if null
      name: json["name"] ?? "",
      companyName: json["company_name"] ?? "",
      gstDetails: json["gst_details"] ?? "",
       email: json["email"] ?? "", // ✅ fallback to ""
      address:
          json["address"] != null
              ? Address.fromJson(json["address"])
              : Address(addressLine: "", city: "", state: "", nationality: ""),
      notificationEnabled: json["notification_enabled"] ?? false,
      isOnline: json["is_online"] ?? false,
      isLocation: json["is_location"] ?? false,
      isCoupen: json["is_coupen"] ?? false,
      isLoginPermission: json["is_login_permission"] ?? false,
      location: json["location"] ?? "",
      mobileToken: json["mobile_token"] ?? "",

      // ✅ Extra fields
      phoneNumber: json["phone_number"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      deletedAt: json["deleted_at"],
      isGstVerified: json["is_gst_verified"] ?? false,
      otp: json["otp"],
      isDeleted: json["is_deleted"] ?? false,
    );
  }
}
