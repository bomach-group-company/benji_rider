class Vendor {
  final int id;
  final String username;
  final String email;

  Vendor({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
