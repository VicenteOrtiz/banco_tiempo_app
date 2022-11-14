import 'dart:convert';

import '../../../../cross_features/category/domain/category_entity.dart';
import '../../domain/publication_entity.dart';

List<PublicationDto> publicationsDtoFromJson(String str) =>
    List<PublicationDto>.from(
        json.decode(str).map((x) => PublicationDto.fromJson(x)));

String publicationDtoToJson(List<PublicationDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicationDto {
  PublicationDto({
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
  List<String> comentarios;
  List<String> imagenes;
  int horas;
  bool oculta;
  List<Categoria> categorias;

  Publication toDomain() {
    return Publication(
      id: id,
      publicado: publicado,
      descripcion: descripcion,
      titulo: titulo,
      creador: creador,
      v: v,
      inscritos: inscritos,
      comentarios: comentarios,
      imagenes: imagenes,
      horas: horas,
      oculta: oculta,
      categorias: categorias,
    );
  }

  factory PublicationDto.fromJson(Map<String, dynamic> json) => PublicationDto(
        id: json["_id"],
        publicado: DateTime.parse(json["publicado"]),
        descripcion: json["descripcion"],
        titulo: json["titulo"],
        creador: json["creador"],
        v: json["__v"],
        inscritos: List<dynamic>.from(json["inscritos"].map((x) => x)),
        comentarios: List<String>.from(json["comentarios"].map((x) => x)),
        imagenes: List<String>.from(json["imagenes"].map((x) => x)),
        horas: json["horas"],
        oculta: json["oculta"],
        categorias: List<Categoria>.from(
            json["categorias"].map((x) => Categoria.fromJson(x))),
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
        "categorias": List<dynamic>.from(categorias.map((x) => x.toJson())),
      };
}
