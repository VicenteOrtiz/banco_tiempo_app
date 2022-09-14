import 'dart:convert';

UserDetailsDto userDetailsDtoFromJson(String str) =>
    UserDetailsDto.fromJson(json.decode(str));

String userDetailsDtoToJson(UserDetailsDto data) => json.encode(data.toJson());

class UserDetailsDto {
  UserDetailsDto({
    required this.admin,
    required this.notificaciones,
    required this.id,
    required this.imagenUrl,
    required this.balance,
    this.error,
  });

  late String? error;
  late bool admin;
  late int notificaciones;
  late String id;
  late String imagenUrl;
  late int balance;

  factory UserDetailsDto.fromJson(Map<String, dynamic> json) => UserDetailsDto(
        admin: json["admin"],
        notificaciones: json["notificaciones"],
        id: json["_id"],
        imagenUrl: json["imagenUrl"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "admin": admin,
        "notificaciones": notificaciones,
        "_id": id,
        "imagenUrl": imagenUrl,
        "balance": balance,
      };

  UserDetailsDto.withError(String errorMessage) {
    error = errorMessage;
  }
}
