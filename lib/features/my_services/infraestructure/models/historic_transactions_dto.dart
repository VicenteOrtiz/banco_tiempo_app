// To parse this JSON data, do
//
//     final historicTransactionsDto = historicTransactionsDtoFromJson(jsonString);

import 'package:banco_tiempo_app/features/services/infraestructure/models/service_dto.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import '../../../../cross_features/public_profile/infraestructure/models/public_profile_dto.dart';

List<HistoricTransactionsDto> historicTransactionsDtoFromJson(String str) =>
    List<HistoricTransactionsDto>.from(
        json.decode(str).map((x) => HistoricTransactionsDto.fromJson(x)));

String historicTransactionsDtoToJson(List<HistoricTransactionsDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoricTransactionsDto {
  HistoricTransactionsDto({
    required this.id,
    required this.creado,
    required this.ofrece,
    required this.horas,
    required this.solicita,
    required this.servicio,
    required this.v,
    required this.finalizado,
    required this.mensajes,
    required this.cualidades,
    required this.aceptado,
    required this.cancelado,
    required this.calificacion,
    required this.comentario,
  });

  String id;
  DateTime creado;
  Ofrece ofrece;
  int horas;
  Ofrece solicita;
  Servicio servicio;
  int v;
  DateTime finalizado;
  List<String> mensajes;
  List<Cualidade> cualidades;
  bool aceptado;
  bool cancelado;
  int calificacion;
  String comentario;

  factory HistoricTransactionsDto.fromJson(Map<String, dynamic> json) =>
      HistoricTransactionsDto(
        id: json["_id"],
        creado: DateTime.parse(json["creado"]),
        ofrece: Ofrece.fromJson(json["ofrece"]),
        horas: json["horas"],
        solicita: Ofrece.fromJson(json["solicita"]),
        servicio: Servicio.fromJson(json["servicio"]),
        v: json["__v"],
        finalizado: DateTime.parse(json["finalizado"]),
        mensajes:
            List<String>.from(json["mensajes"].map((x) => x == null ? "" : x)),
        cualidades: List<Cualidade>.from(
            json["cualidades"].map((x) => Cualidade.fromJson(x))),
        aceptado: json["aceptado"],
        cancelado: json["cancelado"],
        calificacion: json["calificacion"] ?? 0,
        comentario: json["comentario"] == null ? "" : json["comentario"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "creado": creado.toIso8601String(),
        "ofrece": ofrece.toJson(),
        "horas": horas,
        "solicita": solicita.toJson(),
        "servicio": servicio.toJson(),
        "__v": v,
        "finalizado": finalizado.toIso8601String(),
        "mensajes":
            List<dynamic>.from(mensajes.map((x) => x == null ? null : x)),
        "cualidades": List<dynamic>.from(cualidades.map((x) => x.toJson())),
        "aceptado": aceptado,
        "cancelado": cancelado,
        "calificacion": calificacion == null ? null : calificacion,
        "comentario": comentario == null ? null : comentario,
      };
}

class Cualidade {
  Cualidade({
    required this.id,
    required this.nombre,
    required this.imagenUrl,
  });

  String id;
  String nombre;
  String imagenUrl;

  factory Cualidade.fromJson(Map<String, dynamic> json) => Cualidade(
        id: json["_id"],
        nombre: json["nombre"],
        imagenUrl: json["imagenUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "imagenUrl": imagenUrl,
      };
}

class Ofrece {
  Ofrece({
    required this.id,
    required this.lastName,
    required this.name,
    required this.imagenUrl,
  });

  String id;
  String lastName;
  String name;
  String imagenUrl;

  factory Ofrece.fromJson(Map<String, dynamic> json) => Ofrece(
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

class Servicio {
  Servicio({
    required this.id,
    required this.publicado,
    required this.descripcion,
    required this.titulo,
    required this.creador,
    required this.v,
    required this.inscritos,
    //required this.comentarios,
    required this.imagenes,
    required this.horas,
    required this.oculta,
    //required this.categorias,
  });

  String id;
  DateTime publicado;
  String descripcion;
  String titulo;
  String creador;
  int v;
  List<dynamic> inscritos;
  //List<Comentario> comentarios;
  List<dynamic> imagenes;
  int horas;
  bool oculta;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        id: json["_id"],
        publicado: DateTime.parse(json["publicado"]),
        descripcion: json["descripcion"],
        titulo: json["titulo"],
        creador: json["creador"],
        v: json["__v"],
        inscritos: List<dynamic>.from(json["inscritos"].map((x) => x)),
        //comentarios: List<Comentario>.from(json["comentarios"].map((x) => comentarioValues.map[x])),
        imagenes: List<dynamic>.from(json["imagenes"].map((x) => x)),
        horas: json["horas"],
        oculta: json["oculta"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "publicado": publicado.toIso8601String(),
        "descripcion": descripcion,
        "titulo": titulo,
        "creador": creador,
        "__v": v,
        "inscritos": List<dynamic>.from(inscritos.map((x) => x)),
        //"comentarios": List<dynamic>.from(comentarios.map((x) => comentarioValues.reverse[x])),
        "imagenes": List<dynamic>.from(imagenes.map((x) => x)),
        "horas": horas,
        "oculta": oculta,
        //"categorias": List<dynamic>.from(categorias.map((x) => categoriaValues.reverse[x])),
      };
}
