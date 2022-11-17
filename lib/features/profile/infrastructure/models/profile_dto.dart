// To parse this JSON data, do
//
//     final profileDto = profileDtoFromJson(jsonString);

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import '../../domain/profile_entity.dart';

ProfileDto profileDtoFromJson(String str) =>
    ProfileDto.fromJson(json.decode(str));

String profileDtoToJson(ProfileDto data) => json.encode(data.toJson());

class ProfileDto {
  ProfileDto({
    required this.id,
    required this.address,
    required this.rut,
    required this.userType,
    required this.age,
    required this.phone,
    required this.relation,
    required this.lastName,
    required this.email,
    required this.name,
    required this.v,
    required this.fechaNacimiento,
    //required this.datosDeContacto,
    required this.logros,
    required this.notificacionesLeidas,
    required this.notificaciones,
    required this.categorias,
    required this.historialTransacciones,
    required this.transaccionesPendientes,
    required this.imagenUrl,
    required this.activo,
    required this.admin,
    required this.mensajesAyuda,
  });

  String id;
  String address;
  String rut;
  String userType;
  int age;
  String phone;
  int relation;
  String lastName;
  String email;
  String name;
  int v;
  String fechaNacimiento;
  //DatosDeContacto datosDeContacto;
  List<String> logros;
  List<String> notificacionesLeidas;
  List<String> notificaciones;
  List<String> categorias;
  List<String> historialTransacciones;
  List<String> transaccionesPendientes;
  String imagenUrl;
  bool activo;
  bool admin;
  List<String> mensajesAyuda;

  Profile toDomain() {
    return Profile(
      id: id,
      address: address,
      rut: rut,
      userType: userType,
      age: age,
      phone: phone,
      relation: relation,
      lastName: lastName,
      email: email,
      name: name,
      v: v,
      logros: logros,
      notificacionesLeidas: notificacionesLeidas,
      notificaciones: notificaciones,
      categorias: categorias,
      historialTransacciones: historialTransacciones,
      transaccionesPendientes: transaccionesPendientes,
      imagenUrl: imagenUrl,
      activo: activo,
      admin: admin,
      mensajesAyuda: mensajesAyuda,
      birthday: (fechaNacimiento != "")
          ? DateFormat('dd/MM/yyyy').format(DateTime.parse(fechaNacimiento))
          : "",
    );
  }

  factory ProfileDto.fromJson(Map<String, dynamic> json) => ProfileDto(
        id: json["_id"],
        address: json["address"],
        rut: json["rut"],
        userType: json["userType"],
        age: json["age"],
        phone: json["phone"],
        relation: json["relation"],
        lastName: json["lastName"],
        email: json["email"],
        name: json["name"],
        v: json["__v"],
        fechaNacimiento: json["fechaNacimiento"] ?? "",
        //datosDeContacto: DatosDeContacto.fromJson(json["datosDeContacto"]),
        logros: List<String>.from(json["logros"].map((x) => x)),
        notificacionesLeidas:
            List<String>.from(json["notificacionesLeidas"].map((x) => x)),
        notificaciones: List<String>.from(json["notificaciones"].map((x) => x)),
        categorias: List<String>.from(json["categorias"].map((x) => x)),
        historialTransacciones:
            List<String>.from(json["historialTransacciones"].map((x) => x)),
        transaccionesPendientes:
            List<String>.from(json["transaccionesPendientes"].map((x) => x)),
        imagenUrl: json["imagenUrl"],
        activo: json["activo"],
        admin: json["admin"],
        mensajesAyuda: List<String>.from(json["mensajesAyuda"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "rut": rut,
        "userType": userType,
        "age": age,
        "phone": phone,
        "relation": relation,
        "lastName": lastName,
        "email": email,
        "name": name,
        "__v": v,
        "fechaNacimiento": fechaNacimiento,
        //"datosDeContacto": datosDeContacto.toJson(),
        "logros": List<dynamic>.from(logros.map((x) => x)),
        "notificacionesLeidas":
            List<dynamic>.from(notificacionesLeidas.map((x) => x)),
        "notificaciones": List<dynamic>.from(notificaciones.map((x) => x)),
        "categorias": List<dynamic>.from(categorias.map((x) => x)),
        "historialTransacciones":
            List<dynamic>.from(historialTransacciones.map((x) => x)),
        "transaccionesPendientes":
            List<dynamic>.from(transaccionesPendientes.map((x) => x)),
        "imagenUrl": imagenUrl,
        "activo": activo,
        "admin": admin,
        "mensajesAyuda": List<dynamic>.from(mensajesAyuda.map((x) => x)),
      };
}

class DatosDeContacto {
  DatosDeContacto({
    required this.acerca,
    required this.telefono,
    required this.comuna,
    required this.region,
    required this.id,
  });

  String acerca;
  String telefono;
  String comuna;
  String region;
  String id;

  factory DatosDeContacto.fromJson(Map<String, dynamic> json) =>
      DatosDeContacto(
        acerca: json["acerca"],
        telefono: json["telefono"],
        comuna: json["comuna"],
        region: json["region"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "acerca": acerca,
        "telefono": telefono,
        "comuna": comuna,
        "region": region,
        "_id": id,
      };
}
