class ReportResponse {
  final bool status;
  final String message;
  final ReportData? data;

  ReportResponse({required this.status, required this.message, this.data});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ReportData.fromJson(json['data']) : null,
    );
  }
}

class ReportData {
  final int id;
  final String driverId;
  final String reason;
  final String comment;
  final String createdAt;
  final String updatedAt;

  ReportData({
    required this.id,
    required this.driverId,
    required this.reason,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      id: json['id'] ?? 0,
      driverId: json['driver_id'] ?? '',
      reason: json['reason'] ?? '',
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
