// To parse this JSON data, do
//
//     final registrationForm = registrationFormFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegistrationForm registrationFormFromJson(String str) =>
    RegistrationForm.fromJson(json.decode(str));

String registrationFormToJson(RegistrationForm data) =>
    json.encode(data.toJson());

class RegistrationForm {
  RegistrationForm({
    required this.password,
    required this.name,
    required this.lastName,
    required this.relation,
    required this.age,
    required this.address,
    required this.phone,
    required this.rut,
    required this.email,
  });

  factory RegistrationForm.initial() => RegistrationForm(
        address: '',
        age: '',
        email: '',
        lastName: '',
        name: '',
        password: '',
        phone: '',
        relation: '',
        rut: '',
      );

  String password;
  String name;
  String lastName;
  String relation;
  String age;
  String address;
  String phone;
  String rut;
  String email;

  factory RegistrationForm.fromJson(Map<String, dynamic> json) =>
      RegistrationForm(
        password: json["password"],
        name: json["name"],
        lastName: json["lastName"],
        relation: json["relation"],
        age: json["age"],
        address: json["address"],
        phone: json["phone"],
        rut: json["rut"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "name": name,
        "lastName": lastName,
        "relation": relation,
        "age": age,
        "address": address,
        "phone": phone,
        "rut": rut,
        "email": email,
      };
}

class Relation {
  int id;
  String name;

  Relation({
    required this.id,
    required this.name,
  });
}
