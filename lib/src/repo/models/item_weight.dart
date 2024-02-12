import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../providers/constants.dart';
import '../controller/api_url.dart';
import '../utils/helpers.dart';

class ItemWeight {
  final String id;
  final int start;
  final int end;
  final String title;

  ItemWeight({
    required this.id,
    required this.start,
    required this.end,
    required this.title,
  });

  factory ItemWeight.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ItemWeight(
      id: json['id'] ?? notAvailable,
      start: json['start'] ?? 0,
      end: json['end'] ?? 0,
      title: json['title'] ?? notAvailable,
    );
  }
}

Future<List<ItemWeight>> getPackageWeight() async {
  final response = await http.get(
      Uri.parse('${Api.baseUrl}/sendPackage/getPackageWeight/'),
      headers: authHeader());
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => ItemWeight.fromJson(item))
        .toList();
  } else {
    return [];
  }
}
