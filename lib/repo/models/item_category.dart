import 'dart:convert';

import 'package:benji_rider/repo/utils/constants.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

class ItemCategory {
  final String id;
  final String name;

  ItemCategory({
    required this.id,
    required this.name,
  });

  factory ItemCategory.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ItemCategory(
      id: json['id'] ?? notAvailable,
      name: json['name'] ?? notAvailable,
    );
  }
}

Future<List<ItemCategory>> getPackageCategory() async {
  final response = await http.get(
      Uri.parse('$baseURL/sendPackage/getPackageCategory/'),
      headers: authHeader());

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => ItemCategory.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
