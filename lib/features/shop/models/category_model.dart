// ignore_for_file: non_constant_identifier_names

class ThirdLevel {
  int id;
  String name;
  String url_path;
  int level;
  int position;
  int include_in_menu;
  int is_anchor;

  ThirdLevel({
    required this.id,
    required this.name,
    required this.url_path,
    this.level = 3,
    required this.position,
    this.include_in_menu = 1,
    this.is_anchor = 1,
  });

  factory ThirdLevel.fromJson(Map<String, dynamic> json) {
    return ThirdLevel(
      id: json['id'],
      name: json['name'],
      url_path: json['url_path'] ?? '',
      level: json['level'] ?? 3,
      position: json['position'] ?? 1,
      include_in_menu: json['include_in_menu'] ?? 1,
      is_anchor: json['is_anchor'] ?? 1,
    );
  }
}

class SecondLevel {
  int id;
  String name;
  String url_path;
  int level;
  int position;
  int include_in_menu;
  int is_anchor;
  List<ThirdLevel> children;

  SecondLevel({
    required this.id,
    required this.name,
    required this.url_path,
    this.level = 2,
    required this.position,
    this.include_in_menu = 1,
    this.is_anchor = 1,
    this.children = const [],
  });

  factory SecondLevel.fromJson(Map<String, dynamic> json) {
    return SecondLevel(
      id: json['id'],
      name: json['name'],
      url_path: json['url_path'] ?? '',
      level: json['level'] ?? 2,
      position: json['position'] ?? 1,
      include_in_menu: json['include_in_menu'] ?? 1,
      is_anchor: json['is_anchor'] ?? 1,
      children: (json['children'] as List<dynamic>?)
              ?.map((child) => ThirdLevel.fromJson(child))
              .toList() ??
          [],
    );
  }
}

class CategoryModel {
  // Assuming _id can be null
  int id;
  String name;
  String url_path;
  int level;
  int position;
  int include_in_menu;
  int is_anchor;
  bool featured;
  List<SecondLevel> children;

  CategoryModel({
    required this.id,
    required this.name,
    required this.url_path,
    this.level = 2,
    required this.position,
    this.include_in_menu = 1,
    this.is_anchor = 1,
    this.children = const [],
    this.featured = false,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      url_path: json['url_path'] ?? '',
      level: json['level'] ?? 2,
      position: json['position'],
      include_in_menu: json['include_in_menu'] ?? 1,
      is_anchor: json['is_anchor'] ?? 1,
      featured: json['featured'] ?? false,
      children: (json['children'] as List<dynamic>?)
              ?.map((child) => SecondLevel.fromJson(child))
              .toList() ??
          [],
    );
  }
}
