// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:benji_rider/repo/models/order_model.dart';
import 'package:benji_rider/repo/utils/constants.dart';

// acceptanceStatus = ACCP PEND REJE

class TasksModel {
  String id;
  String acceptanceStatus;
  String deliveryStatus;
  String created;
  List<Order> orders;

  TasksModel({
    required this.id,
    required this.acceptanceStatus,
    required this.deliveryStatus,
    required this.created,
    required this.orders,
  });

  factory TasksModel.fromJson(Map<String, dynamic>? json) {
    // print('json json TasksModel $json');
    json ??= {};
    return TasksModel(
      id: json["id"] ?? '',
      acceptanceStatus: json["acceptance_status"] ?? "PEND",
      deliveryStatus: json["delivery_status"] ?? "pending",
      created: json["created_date"] ?? notAvailable,
      orders: json["orders"] == null
          ? []
          : (json["orders"] as List)
              .map((item) => Order.fromJson(item))
              .toList(),
    );
  }
}
