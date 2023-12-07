import 'dart:convert';

import 'package:benji_rider/repo/models/item_category.dart';
import 'package:benji_rider/repo/models/item_weight.dart';
import 'package:benji_rider/repo/models/user_model.dart';
import 'package:benji_rider/repo/utils/constants.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

class Package {
  final String id;
  final User clientId;
  final String pickUpAddress;
  final String senderName;
  final String senderPhoneNumber;
  final String dropOffAddress;
  final String receiverName;
  final String receiverPhoneNumber;
  final String itemName;
  final ItemCategory itemCategory;
  final ItemWeight itemWeight;
  final int itemQuantity;
  final double itemValue;
  final String? itemImage;
  final double prices;
  final String status;
  final String riderReceiveStatus;
  final String dropOffAddressLatitude;
  final String dropOffAddressLongitude;
  final String pickUpAddressLatitude;
  final String pickUpAddressLongitude;

  Package({
    required this.id,
    required this.clientId,
    required this.pickUpAddress,
    required this.senderName,
    required this.senderPhoneNumber,
    required this.dropOffAddress,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.itemName,
    required this.itemCategory,
    required this.itemWeight,
    required this.itemQuantity,
    required this.itemValue,
    required this.itemImage,
    required this.prices,
    required this.status,
    required this.riderReceiveStatus,
    required this.dropOffAddressLatitude,
    required this.dropOffAddressLongitude,
    required this.pickUpAddressLatitude,
    required this.pickUpAddressLongitude,
  });

  factory Package.fromJson(Map<String, dynamic>? json) {
    // print('Package  $json');
    json ??= {};
    return Package(
      id: json['id'] ?? '',
      clientId: User.fromJson(json['client']),
      pickUpAddress: json['pickUpAddress'] ?? notAvailable,
      senderName: json['senderName'] ?? notAvailable,
      senderPhoneNumber: json['senderPhoneNumber'] ?? notAvailable,
      dropOffAddress: json['dropOffAddress'] ?? notAvailable,
      receiverName: json['receiverName'] ?? notAvailable,
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? notAvailable,
      itemName: json['itemName'] ?? notAvailable,
      itemCategory: ItemCategory.fromJson(json['itemCategory']),
      itemWeight: ItemWeight.fromJson(json['itemWeight']),
      itemQuantity: json['itemQuantity'] ?? 0,
      itemValue: json['itemValue'] != null
          ? double.parse(json['itemValue'].toString())
          : 0.0,
      itemImage: json['itemImage'],
      prices: json['prices'] ?? 0.0,
      status: json['status'] ?? 'pending',
      riderReceiveStatus: json['rider_receive_status'] ?? 'pending',
      dropOffAddressLatitude: json['dropOffAddress_latitude'] ?? '',
      dropOffAddressLongitude: json['dropOffAddress_longitude'] ?? '',
      pickUpAddressLatitude: json['pickUpAddress_latitude'] ?? '',
      pickUpAddressLongitude: json['pickUpAddress_longitude'] ?? '',
    );
  }
}

Future<List<Package>> getDeliveryItemsByClientAndStatus(String status) async {
  User? user = await getUser();
  final response = await http.get(
      Uri.parse(
          '$baseURL/sendPackage/gettemPackageByClientId/${user!.id}/$status'),
      headers: authHeader());
  print('packages ${response.statusCode} ${jsonDecode(response.body)}');
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Package.fromJson(item))
        .toList();
  } else {
    return [];
  }
}

Future<Package> getDeliveryItemById(id) async {
  final response = await http.get(
      Uri.parse('$baseURL/sendPackage/gettemPackageById/$id/'),
      headers: authHeader());

  if (response.statusCode == 200) {
    return Package.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load delivery item');
  }
}
