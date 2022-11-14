import 'dart:convert';

import '../../domain/badges_entity.dart';

List<BadgeDto> badgesDtoFromJson(String str) {
  return List<BadgeDto>.from(json.decode(str).map((x) => BadgeDto.fromJson(x)));
}

String badgesDtoToJson(List<BadgeDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BadgeDto {
  BadgeDto({
    required this.id,
    required this.nombre,
    required this.imagenUrl,
    this.v,
    this.error,
  });

  String id = "";
  String nombre = "";
  String imagenUrl = "";
  int? v;
  String? error;

  Badge toDomain() {
    return Badge(
      id: id,
      nombre: nombre,
      imagenUrl: imagenUrl,
    );
  }

  BadgeDto.withError(String errorMessage) {
    error = errorMessage;
  }

  factory BadgeDto.fromJson(Map<String, dynamic> json) => BadgeDto(
        id: json["_id"],
        nombre: json["nombre"],
        imagenUrl: json["imagenUrl"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "imagenUrl": imagenUrl,
        "__v": v == null ? null : v,
      };
}
