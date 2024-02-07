import 'dart:convert';
import 'dart:developer';

import 'package:benji_rider/repo/utils/constants.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

class VendorModel {
  int id;
  String email;
  String phone;
  String username;
  String code;
  String firstName;
  String lastName;
  String gender;
  String address;
  String longitude;
  String latitude;
  String country;
  String state;
  String city;
  String lga;
  String profileLogo;

  VendorModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.username,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.country,
    required this.state,
    required this.city,
    required this.lga,
    required this.profileLogo,
  });

  factory VendorModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    log("JSON data: $json");
    try {
      return VendorModel(
        id: json["id"] ?? 0,
        email: json["email"] ?? notAvailable,
        phone: json["phone"] ?? notAvailable,
        username: json["username"] ?? notAvailable,
        code: json["code"] ?? notAvailable,
        firstName: json["first_name"] ?? notAvailable,
        lastName: json["last_name"] ?? notAvailable,
        gender: json["gender"] ?? notAvailable,
        address: json["address"] ?? notAvailable,
        longitude: json["longitude"] ?? notAvailable,
        latitude: json["latitude"] ?? notAvailable,
        country: json["country"] ?? notAvailable,
        state: json["state"] ?? notAvailable,
        city: json["city"] ?? notAvailable,
        lga: json["lga"] ?? notAvailable,
        profileLogo: json["profileLogo"] ?? '',
      );
    } catch (e) {
      log("Error parsing average_rating: $e");
      return VendorModel.fromJson(null);
      //  return VendorModel.defaults();
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "username": username,
        "code": code,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "lga": lga,
        "profileLogo": profileLogo,
      };
}

Future<VendorModel> getVendorById(id) async {
  final response = await http.get(
    Uri.parse('$baseURL/vendors/getVendor/$id'),
    headers: authHeader(),
  );

  if (response.statusCode == 200) {
    return VendorModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load vendor');
  }
}

Future<List<VendorModel>> getVendors({start = 1, end = 10}) async {
  final response = await http.get(
    Uri.parse('$baseURL/vendors/getAllVendor?start=$start&end=$end'),
    headers: authHeader(),
  );
  if (response.statusCode == 200) {
    return (jsonDecode(response.body)['items'] as List)
        .map((item) => VendorModel.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load vendor');
  }
}
