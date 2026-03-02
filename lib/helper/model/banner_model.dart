class BannerModel {
  final int id;
  final List<String> imageUrls;
  final String? bannerName;
  final String? redirectUrl;

  BannerModel({
    required this.id,
    required this.imageUrls,
    this.bannerName,
    this.redirectUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      imageUrls: List<String>.from(json['image'] ?? []),
      bannerName: json['banners_name'],
      redirectUrl: json['banner_redirect'],
    );
  }
}
