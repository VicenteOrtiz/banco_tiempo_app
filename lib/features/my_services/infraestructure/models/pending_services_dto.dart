// To parse this JSON data, do
//
//     final pendingServicesDto = pendingServicesDtoFromJson(jsonString);

import 'dart:convert';

import 'package:banco_tiempo_app/features/services/infraestructure/models/service_dto.dart';

PendingServicesDto pendingServicesDtoFromJson(String str) =>
    PendingServicesDto.fromJson(json.decode(str));

String pendingServicesDtoToJson(PendingServicesDto data) =>
    json.encode(data.toJson());

class PendingServicesDto {
  PendingServicesDto({
    required this.porConfirmar,
    required this.solicitado,
  });

  List<RequestedServiceDto> porConfirmar;
  List<RequestedServiceDto> solicitado;

  factory PendingServicesDto.fromJson(Map<String, dynamic> json) =>
      PendingServicesDto(
        porConfirmar: List<RequestedServiceDto>.from(
            json["porConfirmar"].map((x) => RequestedServiceDto.fromJson(x))),
        solicitado: List<RequestedServiceDto>.from(
            json["solicitado"].map((x) => RequestedServiceDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "porConfirmar": List<dynamic>.from(porConfirmar.map((x) => x.toJson())),
        "solicitado": List<dynamic>.from(solicitado.map((x) => x.toJson())),
      };
}

class RequestedServiceDto {
  RequestedServiceDto({
    required this.id,
    required this.creado,
    required this.ofrece,
    required this.horas,
    required this.solicita,
    required this.servicio,
    required this.v,
    required this.mensajes,
    required this.cualidades,
    required this.aceptado,
    required this.cancelado,
  });

  String id;
  DateTime creado;
  Ofrece ofrece;
  int horas;
  Ofrece solicita;
  Doc servicio;
  int v;
  List<dynamic> mensajes;
  List<dynamic> cualidades;
  bool aceptado;
  bool cancelado;

  factory RequestedServiceDto.fromJson(Map<String, dynamic> json) =>
      RequestedServiceDto(
        id: json["_id"],
        creado: DateTime.parse(json["creado"]),
        ofrece: Ofrece.fromJson(json["ofrece"]),
        horas: json["horas"],
        solicita: Ofrece.fromJson(json["solicita"]),
        servicio: Doc.fromJson(json["servicio"]),
        v: json["__v"],
        mensajes: List<dynamic>.from(json["mensajes"].map((x) => x)),
        cualidades: List<dynamic>.from(json["cualidades"].map((x) => x)),
        aceptado: json["aceptado"],
        cancelado: json["cancelado"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "creado": creado.toIso8601String(),
        "ofrece": ofrece.toJson(),
        "horas": horas,
        "solicita": solicita.toJson(),
        "servicio": servicio.toJson(),
        "__v": v,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x)),
        "cualidades": List<dynamic>.from(cualidades.map((x) => x)),
        "aceptado": aceptado,
        "cancelado": cancelado,
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
