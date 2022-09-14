import 'package:flutter/material.dart';

class LoginUserEntity {
  late String username;
  late String password;

  Map<String, dynamic> toJson() => {
        'email': username,
        'password': password,
      };
}
