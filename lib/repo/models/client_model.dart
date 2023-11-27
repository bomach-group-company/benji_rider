import 'package:benji_rider/repo/utils/constants.dart';

class Client {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String image;
  final String firstName;
  final String lastName;

  Client({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.firstName,
    required this.lastName,
  });

  factory Client.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return Client(
      id: json['id'] ?? 0,
      username: json['username'] ?? notAvailable,
      email: json['email'] ?? notAvailable,
      phone: json['phone'] ?? notAvailable,
      image: json['image'] ?? '',
      firstName: json['first_name'] ?? notAvailable,
      lastName: json['last_name'] ?? notAvailable,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "phone": phone,
        "image": image,
        "first_name": firstName,
        "last_name": lastName,
      };
}
