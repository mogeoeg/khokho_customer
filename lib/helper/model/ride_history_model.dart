// lib/helper/model/ride_history_model.dart
class RideHistoryModel {
  final int id;
  final String orderNumber;
  final String fromLocation;
  final String destinationLocation;
  final String orderDate;
  final String serviceName;
  final String receiverName;
  final String phoneNumber;
  final String mail;
  final double total;
  final double gtotal;
  final double couponAmount;
  final int status;
  final int paymentMethod;
  final String? updatedAt;

  RideHistoryModel({
    required this.id,
    required this.orderNumber,
    required this.fromLocation,
    required this.destinationLocation,
    required this.orderDate,
    required this.serviceName,
    required this.receiverName,
    required this.phoneNumber,
    required this.mail,
    required this.total,
    required this.gtotal,
    required this.couponAmount,
    required this.status,
    required this.paymentMethod,
    this.updatedAt,
  });

  factory RideHistoryModel.fromJson(Map<String, dynamic> json) {
    return RideHistoryModel(
      id: json['id'],
      orderNumber: json['order_number'] ?? "-",
      fromLocation: json['from_loaction'] ?? "-",
      destinationLocation: json['destination_location'] ?? "-",
      orderDate: json['order_date'] ?? "-",
      updatedAt: json['updated_at'],
      serviceName: json['service_name'] ?? "-",
      receiverName: json['receiver_name'] ?? "-",
      phoneNumber: json['phone_number'] ?? "-",
      mail: json['mail'] ?? "-",
      total: (json['total'] ?? 0).toDouble(),
      gtotal: (json['gtotal'] ?? 0).toDouble(),
      couponAmount: (json['coupon_amount'] ?? 0).toDouble(),
      status: json['status'] ?? 0,
      paymentMethod: json['payment_method'] ?? 0,
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
