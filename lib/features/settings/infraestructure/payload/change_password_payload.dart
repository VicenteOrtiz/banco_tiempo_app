// To parse this JSON data, do
//
//     final changePasswordPayload = changePasswordPayloadFromJson(jsonString);

import 'dart:convert';

ChangePasswordPayload changePasswordPayloadFromJson(String str) =>
    ChangePasswordPayload.fromJson(json.decode(str));

String changePasswordPayloadToJson(ChangePasswordPayload data) =>
    json.encode(data.toJson());

class ChangePasswordPayload {
  ChangePasswordPayload({
    required this.password,
    required this.newPasswordConfirmation,
    required this.newPassword,
  });

  String password;
  String newPasswordConfirmation;
  String newPassword;

  factory ChangePasswordPayload.fromJson(Map<String, dynamic> json) =>
      ChangePasswordPayload(
        password: json["password"],
        newPasswordConfirmation: json["newPasswordConfirmation"],
        newPassword: json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "newPasswordConfirmation": newPasswordConfirmation,
        "newPassword": newPassword,
      };
}
