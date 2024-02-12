import '../../providers/constants.dart';

class Driver {
  final String id;
  final String firstName;
  final String lastName;

  Driver({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] ?? '0',
      firstName: json['first_name'] ?? notAvailable,
      lastName: json['last_name'] ?? notAvailable,
    );
  }
}
