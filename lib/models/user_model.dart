import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String role;
  final String? token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.token,
  });

  factory User.fromFirestore(DocumentSnapshot doc, String? token) {
    Map data = doc.data() as Map<String, dynamic>;;
    return User(
      id: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'user',
      token: token,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'role': role,
        'token': token,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }
}
