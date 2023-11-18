import 'package:benji_rider/repo/utils/constants.dart';

class Address {
  final String id;
  final String title;
  final String details;
  final String phone;
  final bool isCurrent;
  final String latitude;
  final String longitude;

  Address({
    required this.id,
    required this.title,
    required this.details,
    required this.phone,
    required this.isCurrent,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Address(
      id: json['id'] ?? '0',
      title: json['title'] ?? notAvailable,
      details: json['details'] ?? notAvailable,
      phone: json['phone'] ?? notAvailable,
      isCurrent: json['is_current'] ?? false,
      latitude: json['latitude'] ?? notAvailable,
      longitude: json['longitude'] ?? notAvailable,
    );
  }
}
