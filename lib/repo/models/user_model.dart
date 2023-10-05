import 'dart:convert';

class User {
  final int? id;
  final String? email;
  final String? code;
  final String? phone;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? address;
  final String? image;
  final double? balance;
  final String? chassisNumber;
  final String? plateNumber;
  final int? tripCount;
  final String? token;

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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      code: json['code'],
      phone: json['phone'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      address: json['address'],
      image: json['image'],
      balance: json['balance'],
      chassisNumber: json['chassis_number'],
      plateNumber: json['plate_number'],
      tripCount: json['tripCount'],
      token: json['token'],
    );
  }
}

User modelUser(data) {
  return User.fromJson(jsonDecode(data));
}
