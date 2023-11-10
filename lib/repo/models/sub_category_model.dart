import 'package:benji_rider/repo/utils/constants.dart';

import 'category_model.dart';

class SubCategory {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final Category category;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return SubCategory(
      id: json['id'] ?? notAvailable,
      name: json['name'] ?? notAvailable,
      description: json['description'] ?? notAvailable,
      isActive: json['is_active'] ?? false,
      category: Category.fromJson(json['category']),
    );
  }
}
