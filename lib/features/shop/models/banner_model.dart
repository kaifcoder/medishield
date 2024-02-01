class BannerModel {
  final int id;
  final String mobileImage;
  final String title;

  BannerModel({
    required this.id,
    required this.mobileImage,
    required this.title,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      mobileImage: json['mobile_image'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile_image': mobileImage,
      'title': title,
    };
  }
}
