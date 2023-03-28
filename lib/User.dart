import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String email;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> get data => {
        'name': name,
        'mail': email,
        'password': password,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['mail'] ?? '',
      password: map['password'] ?? '',
    );
  }

  User copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return User(
      name: name == null || name == "" ? this.name : name,
      email: email == null || email == "" ? this.email : email,
      password: password == null || password == "" ? this.password : password,
    );
  }
}
