import 'package:benji_rider/repo/models/order_model.dart';
import 'package:benji_rider/repo/models/package.dart';

import '../utils/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class DeliveryModel {
  String id;
  String acceptanceStatus;
  String deliveryStatus;
  Order order;
  String createdDate;
  String deliveredDate;
  Package package;

  DeliveryModel({
    required this.id,
    required this.acceptanceStatus,
    required this.deliveryStatus,
    required this.order,
    required this.createdDate,
    required this.deliveredDate,
    required this.package,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return DeliveryModel(
      id: json["id"] ?? notAvailable,
      acceptanceStatus: json["acceptance_status"] ?? "PEND",
      deliveryStatus: json["delivery_status"] ?? "PEND",
      order: Order.fromJson(json["orders"]),
      createdDate: json["created_date"] ?? '',
      deliveredDate: json["delivered_date_time"] ?? '',
      package: Package.fromJson(json["package"]),
    );
  }

  bool isOrder() {
    return order.id != '';
  }
}
