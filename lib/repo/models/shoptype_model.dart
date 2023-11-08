import 'package:benji_rider/repo/utils/constants.dart';

class ShopTypeModel {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  ShopTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory ShopTypeModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ShopTypeModel(
      id: json['id'] ?? '0',
      name: json['name'] ?? notAvailable,
      description: json['description'] ?? notAvailable,
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_active": isActive,
      };
}
