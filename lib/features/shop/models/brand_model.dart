class BrandModel {
  final String name;
  final int? brandId;
  final int? categoryId;
  final String logo;
  final bool? featured;

  BrandModel({
    required this.name,
    this.brandId,
    this.categoryId,
    required this.logo,
    this.featured,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name'] as String,
      brandId: json['brand_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      logo: json['logo'] as String,
      featured: json['featured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand_id': brandId,
      'category_id': categoryId,
      'logo': logo,
      'featured': featured,
    };
  }
}
