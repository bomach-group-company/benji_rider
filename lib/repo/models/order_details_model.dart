import 'client_model.dart';
import 'product_model.dart';

class OrderDetailsModel {
  final String id;
  final String deliveryAddress;
  final String status;
  final int quantity;
  final String created;
  final Client clientId;
  final ProductModel productId;

  OrderDetailsModel({
    required this.id,
    required this.deliveryAddress,
    required this.status,
    required this.quantity,
    required this.created,
    required this.clientId,
    required this.productId,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      quantity: json['quantity'],
      created: json['created'],
      clientId: Client.fromJson(json['client_id']),
      productId: ProductModel.fromJson(json['product_id']),
    );
  }
}
