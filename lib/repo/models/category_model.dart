import 'package:benji_rider/repo/utils/constants.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Category(
      id: json['id'] ?? notAvailable,
      name: json['name'] ?? notAvailable,
      description: json['description'] ?? notAvailable,
      isActive: json['is_active'] ?? false,
    );
  }
}
