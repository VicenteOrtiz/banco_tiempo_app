// To parse this JSON data, do
//
//     final messagesDto = messagesDtoFromJson(jsonString);

import 'dart:convert';

MessagesDto messagesDtoFromJson(String str) =>
    MessagesDto.fromJson(json.decode(str));

String messagesDtoToJson(MessagesDto data) => json.encode(data.toJson());

class MessagesDto {
  MessagesDto({
    required this.transaccion,
    required this.usuario,
  });

  Transaccion transaccion;
  Usuario usuario;

  factory MessagesDto.fromJson(Map<String, dynamic> json) => MessagesDto(
        transaccion: Transaccion.fromJson(json["transaccion"]),
        usuario: Usuario.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "transaccion": transaccion.toJson(),
        "usuario": usuario.toJson(),
      };
}

class Transaccion {
  Transaccion({
    required this.id,
    required this.creado,
    required this.ofrece,
    required this.horas,
    required this.solicita,
    required this.servicio,
    required this.mensajes,
  });

  String id;
  DateTime creado;
  Usuario ofrece;
  int horas;
  Usuario solicita;
  Servicio servicio;
  List<Mensaje> mensajes;

  factory Transaccion.fromJson(Map<String, dynamic> json) => Transaccion(
        id: json["_id"],
        creado: DateTime.parse(json["creado"]),
        ofrece: Usuario.fromJson(json["ofrece"]),
        horas: json["horas"],
        solicita: Usuario.fromJson(json["solicita"]),
        servicio: Servicio.fromJson(json["servicio"]),
        mensajes:
            List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x)))
                .reversed
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "creado": creado.toIso8601String(),
        "ofrece": ofrece.toJson(),
        "horas": horas,
        "solicita": solicita.toJson(),
        "servicio": servicio.toJson(),
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  Mensaje({
    required this.id,
    required this.fecha,
    required this.texto,
    required this.autor,
    required this.v,
  });

  String id;
  DateTime fecha;
  String texto;
  Autor autor;
  int v;

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        id: json["_id"],
        fecha: DateTime.parse(json["fecha"]),
        texto: json["texto"],
        autor: Autor.fromJson(json["autor"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fecha": fecha.toIso8601String(),
        "texto": texto,
        "autor": autor.toJson(),
        "__v": v,
      };
}

class Autor {
  Autor({
    required this.id,
    required this.hash,
    required this.salt,
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
    required this.logros,
    required this.notificacionesLeidas,
    required this.notificaciones,
    required this.categorias,
    required this.historialTransacciones,
    required this.transaccionesPendientes,
    required this.serviciosPublicados,
    required this.imagenUrl,
    required this.activo,
    required this.admin,
    required this.mensajesAyuda,
    required this.fechaNacimiento,
  });

  String id;
  String hash;
  String salt;
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
  List<String> logros;
  List<String> notificacionesLeidas;
  List<String> notificaciones;
  List<dynamic> categorias;
  List<String> historialTransacciones;
  List<String> transaccionesPendientes;
  List<String> serviciosPublicados;
  String imagenUrl;
  bool activo;
  bool admin;
  List<String> mensajesAyuda;
  DateTime? fechaNacimiento;

  factory Autor.fromJson(Map<String, dynamic> json) => Autor(
        id: json["_id"],
        hash: json["hash"],
        salt: json["salt"] ?? "",
        address: json["address"] ?? "",
        rut: json["rut"] ?? "",
        userType: json["userType"] ?? "",
        age: json["age"] ?? 0,
        phone: json["phone"] ?? "",
        relation: json["relation"] ?? -1,
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        name: json["name"] ?? "",
        v: json["__v"] ?? "",
        logros: List<String>.from(json["logros"].map((x) => x)),
        notificacionesLeidas:
            List<String>.from(json["notificacionesLeidas"].map((x) => x)),
        notificaciones: List<String>.from(json["notificaciones"].map((x) => x)),
        categorias: List<dynamic>.from(json["categorias"].map((x) => x)),
        historialTransacciones:
            List<String>.from(json["historialTransacciones"].map((x) => x)),
        transaccionesPendientes:
            List<String>.from(json["transaccionesPendientes"].map((x) => x)),
        serviciosPublicados:
            List<String>.from(json["serviciosPublicados"].map((x) => x)),
        imagenUrl: json["imagenUrl"],
        activo: json["activo"],
        admin: json["admin"],
        mensajesAyuda: List<String>.from(json["mensajesAyuda"].map((x) => x)),
        fechaNacimiento: json["fechaNacimiento"] == null
            ? null
            : DateTime.parse(json["fechaNacimiento"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hash": hash,
        "salt": salt,
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
        "logros": List<dynamic>.from(logros.map((x) => x)),
        "notificacionesLeidas":
            List<dynamic>.from(notificacionesLeidas.map((x) => x)),
        "notificaciones": List<dynamic>.from(notificaciones.map((x) => x)),
        "categorias": List<dynamic>.from(categorias.map((x) => x)),
        "historialTransacciones":
            List<dynamic>.from(historialTransacciones.map((x) => x)),
        "transaccionesPendientes":
            List<dynamic>.from(transaccionesPendientes.map((x) => x)),
        "serviciosPublicados":
            List<dynamic>.from(serviciosPublicados.map((x) => x)),
        "imagenUrl": imagenUrl,
        "activo": activo,
        "admin": admin,
        "mensajesAyuda": List<dynamic>.from(mensajesAyuda.map((x) => x)),
        "fechaNacimiento":
            fechaNacimiento == null ? null : fechaNacimiento?.toIso8601String(),
      };
}

class Usuario {
  Usuario({
    required this.id,
    required this.lastName,
    required this.email,
    required this.name,
    required this.imagenUrl,
  });

  String id;
  String lastName;
  String email;
  String name;
  String imagenUrl;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        lastName: json["lastName"],
        email: json["email"],
        name: json["name"],
        imagenUrl: json["imagenUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "lastName": lastName,
        "email": email,
        "name": name,
        "imagenUrl": imagenUrl,
      };
}

class Servicio {
  Servicio({
    required this.id,
    required this.titulo,
    required this.imagenes,
    required this.categorias,
  });

  String id;
  String titulo;
  List<dynamic> imagenes;
  List<dynamic> categorias;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        id: json["_id"],
        titulo: json["titulo"],
        imagenes: List<dynamic>.from(json["imagenes"].map((x) => x)),
        categorias: List<dynamic>.from(json["categorias"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "titulo": titulo,
        "imagenes": List<dynamic>.from(imagenes.map((x) => x)),
        "categorias": List<dynamic>.from(categorias.map((x) => x)),
      };
}
