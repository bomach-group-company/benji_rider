import '../../providers/constants.dart';
import 'sub_category_model.dart';
import 'vendor_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantityAvailable;
  final String productImage;
  final bool isAvailable;
  final bool isTrending;
  final bool isRecommended;
  final VendorModel vendorId;
  final SubCategory subCategoryId;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantityAvailable,
    required this.productImage,
    required this.isAvailable,
    required this.isTrending,
    required this.isRecommended,
    required this.vendorId,
    required this.subCategoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ProductModel(
      id: json['id'] ?? notAvailable,
      name: json['name'] ?? notAvailable,
      description: json['description'] ?? notAvailable,
      price: json['price']?.toDouble() ?? 0.0,
      quantityAvailable: json['quantity_available'] ?? 0,
      productImage: json['product_image'] ?? '',
      isAvailable: json['is_available'] ?? false,
      isTrending: json['is_trending'] ?? false,
      isRecommended: json['is_recommended'] ?? false,
      vendorId: VendorModel.fromJson(json['vendor']),
      subCategoryId: SubCategory.fromJson(json['sub_category_id']),
    );
  }
}
