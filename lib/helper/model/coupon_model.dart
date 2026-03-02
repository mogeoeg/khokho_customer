
class CouponModel {
  final int id;
  final String coupenName;
  final String coupenCode;
  final double? couponAmount;
  final String? notes;

  CouponModel({
    required this.id,
    required this.coupenName,
    required this.coupenCode,
    this.couponAmount,
    this.notes,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      coupenName: json['coupen_name'] ?? '',
      coupenCode: json['coupen_code'] ?? '',
      couponAmount:
          (json['coupon_amount'] != null)
              ? (json['coupon_amount'] as num).toDouble()
              : null,
      notes: json['notes'],
    );
  }
}
