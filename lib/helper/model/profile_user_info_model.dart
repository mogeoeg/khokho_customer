// models/user_model.dart
class AddressData {
  final String? addressLine;
  final String? city;
  final String? state;
  final String? nationality;

  AddressData({
    this.addressLine,
    this.city,
    this.state,
    this.nationality,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      addressLine: json['address_line'],
      city: json['city'],
      state: json['state'],
      nationality: json['nationality'],
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

class UserData {
  final int id;
  final String name;
  final String email;
  final String companyName;
  final String gstDetails;
  final bool isOnline;
  final bool notificationEnabled;
  final bool isLocation;
  final bool isGstVerified;
  final bool isLoginPermission;
  final bool isDeleted;
  final String? phoneNumber;
  final String mobileToken;
  final String location;
  final String? otp;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final AddressData? address;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
    required this.gstDetails,
    required this.isOnline,
    required this.notificationEnabled,
    required this.isLocation,
    required this.isGstVerified,
    required this.isLoginPermission,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
    required this.mobileToken,
    this.phoneNumber,
    this.otp,
    this.deletedAt,
    this.address,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      companyName: json['company_name'] ?? "",
      gstDetails: json['gst_details'] ?? "",
      isOnline: json['is_online'] ?? false,
      notificationEnabled: json['notification_enabled'] ?? false,
      isLocation: json['is_location'] ?? false,
      isGstVerified: json['is_gst_verified'] ?? false,
      isLoginPermission: json['is_login_permission'] ?? false,
      isDeleted: json['is_deleted'] ?? false,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      location: json['location'] ?? "",
      mobileToken: json['mobile_token'] ?? "",
      phoneNumber: json['phone_number'],
      otp: json['otp'],
      deletedAt: json['deleted_at'],
      address:
          json['address'] != null ? AddressData.fromJson(json['address']) : null,
    );
  }
}

class ProfileUserModel {
  final bool status;
  final String message;
  final UserData? data;

  ProfileUserModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory  ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return  ProfileUserModel(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}
