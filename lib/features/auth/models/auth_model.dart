class AuthModel {
  bool success;
  String message;
  Student student;

  AuthModel({
    required this.success,
    required this.message,
    required this.student,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json['success'],
      message: json['message'],
      student: Student.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': student.toJson(),
    };
  }
}

class Student {
  String name;
  String email;
  String number;
  String role;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Student({
    required this.name,
    required this.email,
    required this.number,
    required this.role,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      email: json['email'],
      number: json['number'],
      role: json['role'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
      'role': role,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
