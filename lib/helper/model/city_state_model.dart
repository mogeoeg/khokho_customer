// AddressLocation_model.dart
class AddressLocation {
  final int id;
  final String districtName;
  final String districtCode;
  final String stateName;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressLocation({
    required this.id,
    required this.districtName,
    required this.districtCode,
    required this.stateName,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressLocation.fromJson(Map<String, dynamic> json) {
    return AddressLocation(
      id: json['id'],
      districtName: json['district_name'] ?? '',
      districtCode: json['district_code'] ?? '',
      stateName: json['state_name'] ?? '',
      isDeleted: json['is_deleted'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
