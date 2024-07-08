
class User {
  final int id;
  final String? image;
  final String name;
  final String email;
  final String number;
  final String? emailVerifiedAt;
  final String role;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    this.image,
    required this.name,
    required this.email,
    required this.number,
    this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      email: json['email'],
      number: json['number'],
      emailVerifiedAt: json['email_verified_at'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'email': email,
      'number': number,
      'email_verified_at': emailVerifiedAt,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}