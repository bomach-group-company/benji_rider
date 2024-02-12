// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:benji_rider/repo/models/order_model.dart';
// import 'package:benji_rider/repo/models/package.dart';
// import 'package:benji_rider/repo/utils/constants.dart';

// // acceptanceStatus = ACCP PEND REJE

// class DeliveryModel {
//   String id;
//   String acceptanceStatus;
//   String deliveryStatus;
//   String created;
//   Order order;
//   Package package;

//   DeliveryModel({
//     required this.id,
//     required this.acceptanceStatus,
//     required this.deliveryStatus,
//     required this.created,
//     required this.order,
//     required this.package,
//   });

//   factory DeliveryModel.fromJson(Map<String, dynamic>? json) {
//     json ??= {};
//     return DeliveryModel(
//       id: json["id"] ?? '',
//       acceptanceStatus: json["acceptance_status"] ?? "PEND",
//       deliveryStatus: json["delivery_status"] ?? "pending",
//       created: json["created_date"] ?? notAvailable,
//       order: Order.fromJson(json["orders"]),
//       package: Package.fromJson(json["package"]),
//     );
//   }

//   bool isOrder() {
//     return order.id != '';
//   }
// }
