import 'package:benji_rider/repo/utils/constants.dart';

class Client {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String image;

  Client({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
  });

  factory Client.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return Client(
      id: json['id'] ?? 0,
      username: json['username'] ?? notAvailable,
      email: json['email'] ?? notAvailable,
      phone: json['phone'] ?? notAvailable,
      image: json['image'] ?? '',
    );
  }
}
