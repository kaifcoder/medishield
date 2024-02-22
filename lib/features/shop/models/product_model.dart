import 'package:medishield/features/shop/controllers/brand_controller.dart';

class ProductModel {
  final String prodId;
  final int id;
  final String name;
  final String sku;
  final String thumbnailUrl;
  final String shortDescription;
  final String manufacturer;
  final String averageRating;
  final bool isInStock;
  final String isCod;
  final Price price;
  final String RatingCount;
  final List<MediaGalleryEntry> mediaGalleryEntries;
  final List<Category> categories;
  final List<QaData> qaData;
  final List<ChildProduct> childProducts;
  final Map<String, dynamic> productSpecs;
  final List<dynamic> banners;
  final List<dynamic>? ratings;

  ProductModel({
    required this.prodId,
    required this.id,
    required this.name,
    required this.sku,
    required this.thumbnailUrl,
    required this.shortDescription,
    required this.manufacturer,
    required this.averageRating,
    required this.RatingCount,
    required this.isInStock,
    required this.isCod,
    required this.price,
    required this.mediaGalleryEntries,
    required this.categories,
    required this.qaData,
    required this.childProducts,
    required this.productSpecs,
    required this.banners,
    this.ratings,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      prodId: json['_id'] ?? '',
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      sku: json['sku'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      shortDescription: json['short_description'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      averageRating: json['average_rating'] ?? '0.0',
      RatingCount: json['rating_count'] ?? '0',
      isInStock: json['max_sale_qty'] > 0 ? true : false,
      isCod: json['is_cod'] ?? '',
      price: Price.fromJson(json['price'] ?? {}),
      mediaGalleryEntries: List<MediaGalleryEntry>.from(
          (json['media_gallery_entries'] ?? [])
              .map((entry) => MediaGalleryEntry.fromJson(entry))),
      categories: List<Category>.from(
          (json['categories'] ?? []).map((cat) => Category.fromJson(cat))),
      qaData: List<QaData>.from(
          (json['qa_data'] ?? []).map((qa) => QaData.fromJson(qa))),
      childProducts: List<ChildProduct>.from((json['childProducts'] ?? [])
          .map((child) => ChildProduct.fromJson(child))),
      productSpecs: json['product_specs'] ?? {},
      banners: json['banners'] ?? [],
      ratings: json['reviews'] ?? [],
    );
  }

  static getManufacture(manufacturer) {
    if (manufacturer.contains(RegExp(r'[a-zA-Z]'))) return manufacturer;
    var manuId = int.parse(manufacturer);
    final brandName = BrandController.instance.brandList
        .firstWhere((element) => element.brandId == manuId)
        .name;
    return brandName;
  }

  static getaverageRating(int totalRating, int fiveStar, int fourStar,
      int threeStar, int twoStar, int oneStar) {
    final ratingSum =
        fiveStar * 5 + fourStar * 4 + threeStar * 3 + twoStar * 2 + oneStar * 1;
    final averageRating = ratingSum / totalRating;
    return averageRating;
  }

  static Map<int, int> countRatings(List<dynamic> reviews) {
    Map<int, int> ratingsCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (var review in reviews) {
      int rating = review['rating'];
      if (ratingsCount.containsKey(rating)) {
        if (ratingsCount.containsKey(rating)) {
          ratingsCount[rating] = ratingsCount[rating]! + 1;
        }
      }
    }

    return ratingsCount;
  }
}

class Price {
  final int minimalPrice;
  final int maximalPrice;
  final int regularPrice;

  Price({
    required this.minimalPrice,
    required this.maximalPrice,
    required this.regularPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      minimalPrice: json['minimalPrice'] ?? 0,
      maximalPrice: json['maximalPrice'] ?? 0,
      regularPrice: json['regularPrice'] ?? 0,
    );
  }
}

class ChildProductPrice {
  final int minimalPrice;
  final int maximalPrice;
  final int regularPrice;

  ChildProductPrice({
    required this.minimalPrice,
    required this.maximalPrice,
    required this.regularPrice,
  });

  factory ChildProductPrice.fromJson(Map<String, dynamic> json) {
    return ChildProductPrice(
      minimalPrice: json['minimalPrice']?['amount']?['value'] ?? 0,
      maximalPrice: json['maximalPrice']?['amount']?['value'] ?? 0,
      regularPrice: json['regularPrice']?['amount']?['value'] ?? 0,
    );
  }
}

class MediaGalleryEntry {
  final int id;
  final String mediaType;
  final String label;
  final String file;

  MediaGalleryEntry({
    required this.id,
    required this.mediaType,
    required this.label,
    required this.file,
  });

  factory MediaGalleryEntry.fromJson(Map<String, dynamic> json) {
    return MediaGalleryEntry(
      id: json['id'] ?? 0,
      mediaType: json['media_type'] ?? '',
      label: json['label'] ?? '',
      file: json['file'] ?? '',
    );
  }
}

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
    );
  }
}

class QaData {
  final String question;
  final String answer;
  final int like;
  final int dislike;

  QaData({
    required this.question,
    required this.answer,
    required this.like,
    required this.dislike,
  });

  factory QaData.fromJson(Map<String, dynamic> json) {
    return QaData(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      like: json['like'] ?? 0,
      dislike: json['dislike'] ?? 0,
    );
  }
}

class ChildProduct {
  final id;
  final String imageUrl;
  final String name;
  final String sku;
  final int? specialPrice;
  final String shortDescription;
  final String manufacturer;
  final String averageRating;
  final String ratingCount;
  final bool isInStock;
  final String? pdExpiryDate;
  final ChildProductPrice price;
  final List<MediaGalleryEntry> mediaGalleryEntries;
  final List<String> categories;

  ChildProduct({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.sku,
    this.specialPrice,
    required this.shortDescription,
    required this.manufacturer,
    required this.averageRating,
    required this.ratingCount,
    required this.isInStock,
    required this.pdExpiryDate,
    required this.price,
    required this.mediaGalleryEntries,
    required this.categories,
  });

  factory ChildProduct.fromJson(Map<String, dynamic> json) {
    return ChildProduct(
      id: json['id'] ?? '',
      imageUrl: json['image_url'] ?? '',
      name: json['name'] ?? '',
      sku: json['sku'] ?? '',
      specialPrice: json['special_price'] ?? 0,
      shortDescription: json['short_description'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      averageRating: json['average_rating'] ?? '',
      ratingCount: json['rating_count'] ?? '',
      isInStock: json['is_in_stock'] ?? false,
      pdExpiryDate: json['pd_expiry_date'] ?? '',
      price: ChildProductPrice.fromJson(json['price'] ?? {}),
      mediaGalleryEntries: List<MediaGalleryEntry>.from(
        (json['media_gallery_entries'] ?? []).map(
          (entry) => MediaGalleryEntry.fromJson(entry),
        ),
      ),
      categories: List<String>.from(json['categories'] ?? []),
    );
  }
}
