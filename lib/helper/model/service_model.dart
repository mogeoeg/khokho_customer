// // ✅ MODEL: service_model.dart
// class ServiceModel {
//   final int id;
//   final String serviceName;
//   final String notes;
//   final double serviceAmount;
//   final double extraCharges;

//   ServiceModel({
//     required this.id,
//     required this.serviceName,
//     required this.notes,
//     required this.serviceAmount,
//     required this.extraCharges,
//   });

//   factory ServiceModel.fromJson(Map<String, dynamic> json) {
//     return ServiceModel(
//       id: json['id'],
//       serviceName: json['service_name'],
//       notes: json['notes'],
//       serviceAmount: (json['service_amount'] ?? 0).toDouble(),
//       extraCharges: (json['extra_charges'] ?? 0).toDouble(),
//     );
//   }

//   // ✅ Getter to calculate total price
//   double get totalPrice => serviceAmount + extraCharges;
// }

// ✅ MODEL: service_model.dart
class ServiceModel {
  final int id;
  final String? vehicleType;
  final String? vehicleLoadCapacity;
  final double serviceAmount;
  final double tax;
  final double extraCharges;
  final String? serviceValidity;
  final bool? isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  ServiceModel({
    required this.id,
    this.vehicleType,
    this.vehicleLoadCapacity,
    required this.serviceAmount,
    required this.tax,
    required this.extraCharges,
    this.serviceValidity,
    this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      vehicleType: json['vehicle_type'],
      vehicleLoadCapacity: json['vehicle_load_capacity'],
      serviceAmount: (json['service_amount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      extraCharges: (json['extra_charges'] ?? 0).toDouble(),
      serviceValidity: json['service_validity'],
      isActive: json['is_active'],
      isDeleted: json['is_deleted'] ?? false,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now(), // or handle as null if you make createdAt nullable

      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : DateTime.now(),

      // createdAt: DateTime.parse(json['created_at']),
      // updatedAt: DateTime.parse(json['updated_at']),
      deletedAt:
          json['deleted_at'] != null
              ? DateTime.tryParse(json['deleted_at'])
              : null,
    );
  }

  // ✅ Getter for total amount including tax & extra charges
  double get totalAmount => serviceAmount + tax + extraCharges;
}
