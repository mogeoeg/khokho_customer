// class FetchOrderModel {
//   final int id;
//   final String? orderNumber;
//   final String? fromLocation;
//   final String? destinationLocation;
//   final String? orderDate;
//   final String? updatedAt;
//   final String? receiverName;
//   final String? phoneNumber;
//   final String? mail;
//   final String? goodsType;
//   final int paymentMethod;
//   final String? serviceName;
//   final double? total;
//   final double? gtotal;
//   final double? couponAmount;
//   final int status;

//   FetchOrderModel({
//     this.couponAmount,
//     this.updatedAt,
//     required this.id,
//     this.orderNumber,
//     this.fromLocation,
//     required this.paymentMethod,
//     this.destinationLocation,
//     this.orderDate,
//     this.receiverName,
//     this.phoneNumber,
//     this.mail,
//     this.goodsType,
//     this.serviceName,
//     this.total,
//     this.gtotal,
//     required this.status,
//   });

//   factory FetchOrderModel.fromJson(Map<String, dynamic> json) {
//     return FetchOrderModel(
//       id: json['id'],
//       orderNumber: json['order_number'],
//       fromLocation: json['from_loaction'],
//       destinationLocation: json['destination_location'],
//       orderDate: json['order_date'],
//       updatedAt: json['updated_at'],
//       receiverName: json['receiver_name'],
//       phoneNumber: json['phone_number'],
//       mail: json['mail'],
//       goodsType: json['goods_type'],
//       serviceName: json['service_name'],
//       total: (json['total'] ?? 0).toDouble(),
//       gtotal: (json['gtotal'] ?? 0).toDouble(),
//       status: json['status'],
//       couponAmount: (json['coupon_amount'] ?? 0).toDouble(),
//       paymentMethod: json['payment_method'],
//     );
//   }

//   String get statusText {
//   switch (status) {
//     case 0:
//       return "Pending";
//     case 1:
//       return "Onprocess";
//     case 2:
//       return "Delivered";
//     case 3:
//       return "Cancelled";
//     case 4:
//       return "Confirmed";
//     case 5:
//       return "PickUp";
//     default:
//       return "Unknown";
//   }
// }

//   // String get statusText {
//   //   switch (status) {
//   //     case 0:
//   //       return "Pending";
//   //     case 1:
//   //       return "Onprocess";
//   //     case 2:
//   //       return "Delivered";
//   //     case 3:
//   //       return "Cancelled";
//   //     default:
//   //       return "Unknown";
//   //   }
//   // }
// }

class FetchOrderModel {
  final int id;
  final String? orderNumber;
  final int? userId;
  final int? driverId;
  final String? fromLocation;
  final String? destinationLocation;
  final String? orderDate;
  final String? updatedAt;
  final String? createdAt;
  final String? deletedAt;
  final String? receiverName;
  final String? phoneNumber;
  final String? mail;
  final String? goodsType;
  final int paymentMethod;
  final int paymentStatus;
  final String? serviceName;
  final double? total;
  final double? gtotal;
  final double? couponAmount;
  final int status;
  final int? services;
  final int? distance;
  final String? totalTimeTaken;
  final int? couponId;
  final String? longitude;
  final String? latitude;
  final String? notes;
  final String? transactionId;
  final String? paymentDateAndTime;
  final String? paymentGatewayId;
  final String? paymentSubscriptionId;
  final bool? isDeleted;

  final UserDetailsModel? userDetails;
  final DriverDetailsModel? driverDetails;

  FetchOrderModel({
    required this.id,
    this.orderNumber,
    this.userId,
    this.driverId,
    this.fromLocation,
    this.destinationLocation,
    this.orderDate,
    this.updatedAt,
    this.createdAt,
    this.deletedAt,
    this.receiverName,
    this.phoneNumber,
    this.mail,
    this.goodsType,
    required this.paymentMethod,
    required this.paymentStatus,
    this.serviceName,
    this.total,
    this.gtotal,
    this.couponAmount,
    required this.status,
    this.services,
    this.distance,
    this.totalTimeTaken,
    this.couponId,
    this.longitude,
    this.latitude,
    this.notes,
    this.transactionId,
    this.paymentDateAndTime,
    this.paymentGatewayId,
    this.paymentSubscriptionId,
    this.isDeleted,
    this.userDetails,
    this.driverDetails,
  });

  factory FetchOrderModel.fromJson(Map<String, dynamic> json) {
    return FetchOrderModel(
      id: json['id'],
      orderNumber: json['order_number'],
      userId: json['userid'],
      driverId: json['driverid'],
      fromLocation: json['from_loaction'],
      destinationLocation: json['destination_location'],
      orderDate: json['order_date'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      deletedAt: json['deleted_at'],
      receiverName: json['receiver_name'],
      phoneNumber: json['phone_number'],
      mail: json['mail'],
      goodsType: json['goods_type'],
      paymentMethod: json['payment_method'] ?? 0,
      paymentStatus: json['payment_status'] ?? 0,
      serviceName: json['service_name'],
      //total: (json['total']?.toDouble() ?? 0.0),

      //  gtotal: (json['gtotal'] ?? 0).toDouble(),

      // gtotal: (json['gtotal'] is int)
      // ? (json['gtotal'] as int).toDouble()
      // : (json['gtotal'] ?? 0).toDouble(),
      // gtotal: (json['gtotal']?.toDouble() ?? 0.0),

      //couponAmount: (json['coupon_amount'] ?? 0).toDouble(),
      // couponAmount: (json['coupon_amount']?.toDouble() ?? 0.0),
      status: json['status'],

      // services: json['services'],
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      gtotal: (json['gtotal'] as num?)?.toDouble() ?? 0.0,
      couponAmount: (json['coupon_amount'] as num?)?.toDouble() ?? 0.0,

      // distance: json['distance'],
      services:
          json['services'] != null ? (json['services'] as num).toInt() : null,
      distance:
          json['distance'] != null ? (json['distance'] as num).toInt() : null,
      couponId:
          json['coupon_id'] != null ? (json['coupon_id'] as num).toInt() : null,

      totalTimeTaken: json['total_time_taken'],
      //couponId: json['coupon_id'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      notes: json['notes'],
      transactionId: json['transaction_id'],
      paymentDateAndTime: json['payment_date_and_time'],
      paymentGatewayId: json['payment_gateway_id'],
      paymentSubscriptionId: json['payment_subscription_id'],
      isDeleted: json['is_deleted'],
      userDetails:
          json['userdetails'] != null
              ? UserDetailsModel.fromJson(json['userdetails'])
              : null,
      driverDetails:
          json['driverdetails'] != null
              ? DriverDetailsModel.fromJson(json['driverdetails'])
              : null,
    );
  }

  String get statusText {
    switch (status) {
      case 0:
        return "Pending";
      case 1:
        return "Onprocess";
      case 2:
        return "Delivered";
      case 3:
        return "Cancelled";
      case 4:
        return "Confirmed";
      case 5:
        return "PickUp";
      default:
        return "Unknown";
    }
  }
}

class UserDetailsModel {
  final int id;
  final String? name;
  final String? phoneNumber;
  final String? companyName;
  final String? gstDetails;
  final String? email;
  final AddressModel? address;

  UserDetailsModel({
    required this.id,
    this.name,
    this.phoneNumber,
    this.companyName,
    this.gstDetails,
    this.email,
    this.address,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      companyName: json['company_name'],
      gstDetails: json['gst_details'],
      email: json['email'],
      address:
          json['address'] != null
              ? AddressModel.fromJson(json['address'])
              : null,
    );
  }
}

class DriverDetailsModel {
  final int id;
  final String? name;
  final String? phoneNumber;
  final String? licenseNumber;
  final String? vehicleNumber;
  final String? email;
  final AddressModel? address;
  final String? licenseLink;
  final String? aadhaarLink;
  final String? profilePic;
  final String? vehicleType;
  final String? vehicleLoadCapacity;

  DriverDetailsModel({
    required this.id,
    this.name,
    this.phoneNumber,
    this.licenseNumber,
    this.vehicleNumber,
    this.email,
    this.address,
    this.licenseLink,
    this.aadhaarLink,
    this.profilePic,
    this.vehicleType,
    this.vehicleLoadCapacity,
  });

  factory DriverDetailsModel.fromJson(Map<String, dynamic> json) {
    return DriverDetailsModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      licenseNumber: json['license_number'],
      vehicleNumber: json['vehicle_number'],
      email: json['email'],
      address:
          json['address'] != null
              ? AddressModel.fromJson(json['address'])
              : null,
      licenseLink: json['license_link'],
      aadhaarLink: json['aadhaar_link'],
      profilePic: json['profile_pic'],
      vehicleType: json['vehicle_type'],
      vehicleLoadCapacity: json['vehicle_load_capacity'],
    );
  }
}

class AddressModel {
  final String? addressLine;
  final String? city;
  final String? state;
  final String? nationality;

  AddressModel({this.addressLine, this.city, this.state, this.nationality});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressLine: json['address_line'],
      city: json['city'],
      state: json['state'],
      nationality: json['nationality'],
    );
  }
}
