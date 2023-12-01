import 'dart:convert';

import 'package:benji_rider/repo/utils/constants.dart';

class User {
  final int id;
  final String email;
  final String code;
  final String phone;
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final String address;
  final String image;
  final double balance;
  final String chassisNumber;
  final String plateNumber;
  final int tripCount;
  final String token;
  final bool isVisibleCash;

  const User({
    required this.id,
    required this.email,
    required this.code,
    required this.phone,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.image,
    required this.balance,
    required this.chassisNumber,
    required this.plateNumber,
    required this.tripCount,
    required this.token,
    required this.isVisibleCash,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? notAvailable,
      code: json['code'] ?? notAvailable,
      phone: json['phone'] ?? notAvailable,
      username: json['username'] ?? notAvailable,
      firstName: json['first_name'] ?? notAvailable,
      lastName: json['last_name'] ?? notAvailable,
      gender: json['gender'] ?? notAvailable,
      address: json['address'] ?? notAvailable,
      image: json['image'] ?? notAvailable,
      balance: json['balance'] ?? 0.0,
      chassisNumber: json['chassis_number'] ?? notAvailable,
      plateNumber: json['plate_number'] ?? notAvailable,
      tripCount: json['tripCount'] ?? 0,
      token: json['token'] ?? notAvailable,
      isVisibleCash: json['isVisibleCash'] ?? true,
    );
  }
}

User modelUser(data) {
  return User.fromJson(jsonDecode(data));
}
