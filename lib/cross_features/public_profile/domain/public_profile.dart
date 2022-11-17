// To parse this JSON data, do
//
//     final publicProfileDto = publicProfileDtoFromJson(jsonString);

import 'package:banco_tiempo_app/cross_features/public_profile/infraestructure/models/public_profile_dto.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class PublicProfile {
  PublicProfile({
    required this.comentarios,
    required this.puntaje,
    required this.cualidades,
  });

  List<Comentario> comentarios;
  int puntaje;
  List<Cualidad> cualidades;

  /* factory PublicProfile.fromJson(Map<String, dynamic> json) => PublicProfile(
        comentarios: List<dynamic>.from(json["comentarios"].map((x) => x)),
        puntaje: json["puntaje"],
        cualidades: List<Cualidad>.from(
            json["cualidades"].map((x) => Cualidad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comentarios": List<dynamic>.from(comentarios.map((x) => x)),
        "puntaje": puntaje,
        "cualidades": List<dynamic>.from(cualidades.map((x) => x.toJson())),
      }; */
}

class Cualidad {
  Cualidad({
    required this.id,
    this.puntaje,
    required this.nombre,
    required this.imagenUrl,
  });

  String id;
  int? puntaje;
  String nombre;
  String imagenUrl;

  factory Cualidad.fromJson(Map<String, dynamic> json) => Cualidad(
        id: json["_id"],
        puntaje: json["puntaje"] ?? 0,
        nombre: json["nombre"],
        imagenUrl: json["imagenUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "puntaje": puntaje,
        "nombre": nombre,
        "imagenUrl": imagenUrl,
      };
}
