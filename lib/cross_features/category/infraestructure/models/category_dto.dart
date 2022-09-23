import 'dart:convert';

import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';

List<CategoryDto> categoryDtoFromJson(String str) {
  return List<CategoryDto>.from(
      json.decode(str).map((x) => CategoryDto.fromJson(x)));
}

String categoryDtoToJson(List<CategoryDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryDto {
  CategoryDto({
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

  Categoria toDomain() {
    return Categoria(
      id: id,
      nombre: nombre,
      imagenUrl: imagenUrl,
    );
  }

  CategoryDto.withError(String errorMessage) {
    error = errorMessage;
  }

  factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(
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
