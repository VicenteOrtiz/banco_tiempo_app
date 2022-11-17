import 'package:meta/meta.dart';
import 'dart:convert';

EditProfileForm editProfileFromJson(String str) =>
    EditProfileForm.fromJson(json.decode(str));

String editProfileToJson(EditProfileForm data) => json.encode(data.toJson());

class EditProfileForm {
  EditProfileForm({
    required this.name,
    required this.lastName,
    this.fechaNacimiento,
    required this.rut,
  });

  String name;
  String lastName;
  DateTime? fechaNacimiento;
  String rut;

  factory EditProfileForm.fromJson(Map<String, dynamic> json) =>
      EditProfileForm(
        name: json["name"],
        lastName: json["lastName"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        rut: json["rut"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "fechaNacimiento": fechaNacimiento?.toIso8601String(),
        "rut": rut,
      };
}
