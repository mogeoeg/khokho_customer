class CreateOrderModel {
  final String fromLocation;
  final String destinationLocation;
  final String receiverName;
  final String? mail;
  final String phoneNumber;
  final int services;
  final String goodsType;
  final double total;
  final int paymentMethod;
  final int paymentStatus;
  final String serviceName;
  final double distance;
  final String totalTimeTaken;
  final int? couponId;
  final double? couponAmount;
  final String longitude;
  final String latitude;
  final int gTotal;
  final int status;

  final String? notes;
  final String? transactionId;
  final String? paymentDateAndTime;
  final String? paymentGatewayId;
  final String? paymentSubscriptionId;

  CreateOrderModel({
    required this.fromLocation,
    required this.destinationLocation,
    required this.receiverName,
    required this.mail,
    required this.phoneNumber,
    required this.services,
    required this.goodsType,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.serviceName,
    required this.distance,
    required this.totalTimeTaken,
    this.couponId,
    this.couponAmount,
    required this.longitude,
    required this.latitude,
    required this.gTotal,
    required this.status,

      this.notes,
    this.transactionId,
    this.paymentDateAndTime,
    this.paymentGatewayId,
    this.paymentSubscriptionId,
  });

  Map<String, dynamic> toJson() {
    return {
      "from_loaction": fromLocation,
      "destination_location": destinationLocation,
      "receiver_name": receiverName,
      "mail": mail ?? "",
      "phone_number": phoneNumber,
      "services": services,
      "goods_type": goodsType,
      "total": total,
      "payment_method": paymentMethod,
      "payment_status": paymentStatus,
      "service_name": serviceName,
      "distance": distance,
      "total_time_taken": totalTimeTaken ,
     "coupon_id": couponId?? 0, // keep int
    "coupon_amount": couponAmount?? 0.0,
      "longitude": longitude,
      "latitude": latitude,
      "gtotal": gTotal,
      "status": status,

      // optional extra fields from swagger
      if (notes != null) "notes": notes,
      if (transactionId != null) "transaction_id": transactionId,
      if (paymentDateAndTime != null) "payment_date_and_time": paymentDateAndTime,
      if (paymentGatewayId != null) "payment_gateway_id": paymentGatewayId,
      if (paymentSubscriptionId != null)
        "payment_subscription_id": paymentSubscriptionId,
    };
  }
}
