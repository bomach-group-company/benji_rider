import 'dart:convert';

import 'package:benji_rider/repo/models/percentage_model.dart';
import 'package:benji_rider/repo/models/user_model.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'driver_model.dart';
import 'order_details_model.dart';

class Order {
  final String id;
  final OrderDetailsModel orderId;
  final Driver driverId;
  final double amount;
  final Percentage percentageId;
  final int status;

  Order({
    required this.id,
    required this.orderId,
    required this.driverId,
    required this.amount,
    required this.percentageId,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return Order(
      id: json['id'] ?? '0',
      orderId: OrderDetailsModel.fromJson(json['order_id']),
      driverId: Driver.fromJson(json['driver_id']),
      amount: (json['amount'] ?? 0.0) as double,
      percentageId: Percentage.fromJson(json['percentage_id']),
      status: json['status'] ?? 0,
    );
  }
}

Future<List<Order>> fetchOrdersByDriver() async {
  User? user = await getUser();
  final response = await http
      .get(Uri.parse('$baseURL/drivers/commissionEarned/${user!.id}'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Order.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load orders');
  }
}
