// To parse this JSON data, do
//
//     final publicProfileDto = publicProfileDtoFromJson(jsonString);
import 'dart:convert';

import '../../domain/public_profile.dart';

PublicProfileDto publicProfileDtoFromJson(String str) =>
    PublicProfileDto.fromJson(json.decode(str));

String publicProfileDtoToJson(PublicProfileDto data) =>
    json.encode(data.toJson());

class PublicProfileDto {
  PublicProfileDto({
    required this.comentarios,
    required this.puntaje,
    required this.cualidades,
  });

  List<Comentario> comentarios;
  int puntaje;
  List<Cualidad> cualidades;

  PublicProfile toDomain() {
    return PublicProfile(
        comentarios: comentarios, puntaje: puntaje, cualidades: cualidades);
  }

  factory PublicProfileDto.fromJson(Map<String, dynamic> json) =>
      PublicProfileDto(
        comentarios: List<Comentario>.from(
            json["comentarios"].map((x) => Comentario.fromJson(x))),
        puntaje: json["puntaje"] ?? 0,
        cualidades: List<Cualidad>.from(
            json["cualidades"].map((x) => Cualidad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comentarios": List<dynamic>.from(comentarios.map((x) => x.toJson())),
        "puntaje": puntaje,
        "cualidades": List<dynamic>.from(cualidades.map((x) => x.toJson())),
      };
}

class Comentario {
  Comentario({
    required this.id,
    required this.creado,
    required this.ofrece,
    required this.horas,
    required this.solicita,
    required this.servicio,
    required this.v,
    required this.calificacion,
    required this.comentario,
    required this.finalizado,
    required this.mensajes,
    required this.cualidades,
    required this.aceptado,
    required this.cancelado,
  });

  String id;
  DateTime creado;
  String ofrece;
  int horas;
  Solicita solicita;
  Servicio servicio;
  int v;
  int calificacion;
  String comentario;
  DateTime finalizado;
  List<dynamic> mensajes;
  List<Cualidad> cualidades;
  bool aceptado;
  bool cancelado;

  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        id: json["_id"],
        creado: DateTime.parse(json["creado"]),
        ofrece: json["ofrece"],
        horas: json["horas"],
        solicita: Solicita.fromJson(json["solicita"]),
        servicio: Servicio.fromJson(json["servicio"]),
        v: json["__v"],
        calificacion: json["calificacion"],
        comentario: json["comentario"],
        finalizado: DateTime.parse(json["finalizado"]),
        mensajes: List<dynamic>.from(json["mensajes"].map((x) => x)),
        cualidades: List<Cualidad>.from(
            json["cualidades"].map((x) => Cualidad.fromJson(x))),
        aceptado: json["aceptado"],
        cancelado: json["cancelado"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "creado": creado.toIso8601String(),
        "ofrece": ofrece,
        "horas": horas,
        "solicita": solicita.toJson(),
        "servicio": servicio.toJson(),
        "__v": v,
        "calificacion": calificacion,
        "comentario": comentario,
        "finalizado": finalizado.toIso8601String(),
        "mensajes": List<dynamic>.from(mensajes.map((x) => x)),
        "cualidades": List<dynamic>.from(cualidades.map((x) => x.toJson())),
        "aceptado": aceptado,
        "cancelado": cancelado,
      };
}

class Servicio {
  Servicio({
    required this.id,
    required this.publicado,
    required this.descripcion,
    required this.titulo,
    required this.creador,
    required this.v,
    required this.inscritos,
    required this.comentarios,
    required this.imagenes,
    required this.horas,
    required this.oculta,
    required this.categorias,
  });

  String id;
  DateTime publicado;
  String descripcion;
  String titulo;
  String creador;
  int v;
  List<dynamic> inscritos;
  List<dynamic> comentarios;
  List<dynamic> imagenes;
  int horas;
  bool oculta;
  List<dynamic> categorias;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        id: json["_id"],
        publicado: DateTime.parse(json["publicado"]),
        descripcion: json["descripcion"],
        titulo: json["titulo"],
        creador: json["creador"],
        v: json["__v"],
        inscritos: List<dynamic>.from(json["inscritos"].map((x) => x)),
        comentarios: List<dynamic>.from(json["comentarios"].map((x) => x)),
        imagenes: List<dynamic>.from(json["imagenes"].map((x) => x)),
        horas: json["horas"],
        oculta: json["oculta"],
        categorias: List<dynamic>.from(json["categorias"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "publicado": publicado.toIso8601String(),
        "descripcion": descripcion,
        "titulo": titulo,
        "creador": creador,
        "__v": v,
        "inscritos": List<dynamic>.from(inscritos.map((x) => x)),
        "comentarios": List<dynamic>.from(comentarios.map((x) => x)),
        "imagenes": List<dynamic>.from(imagenes.map((x) => x)),
        "horas": horas,
        "oculta": oculta,
        "categorias": List<dynamic>.from(categorias.map((x) => x)),
      };
}

class Solicita {
  Solicita({
    required this.id,
    required this.lastName,
    required this.name,
    required this.imagenUrl,
  });

  String id;
  String lastName;
  String name;
  String imagenUrl;

  factory Solicita.fromJson(Map<String, dynamic> json) => Solicita(
        id: json["_id"],
        lastName: json["lastName"],
        name: json["name"],
        imagenUrl: json["imagenUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "lastName": lastName,
        "name": name,
        "imagenUrl": imagenUrl,
      };
}
