import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../providers/constants.dart';
import '../controller/api_url.dart';
import '../utils/helpers.dart';

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
      Uri.parse('${Api.baseUrl}/sendPackage/getPackageCategory/'),
      headers: authHeader());

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => ItemCategory.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
