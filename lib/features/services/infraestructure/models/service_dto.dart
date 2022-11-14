// To parse this JSON data, do
//
//     final servicesDto = servicesDtoFromJson(jsonString);

import 'dart:convert';

import '../../../../cross_features/category/domain/category_entity.dart';
import '../../domain/service_entity.dart';

ServicesDto servicesDtoFromJson(String str) =>
    ServicesDto.fromJson(json.decode(str));

String servicesDtoToJson(ServicesDto data) => json.encode(data.toJson());

class ServicesDto {
  ServicesDto({
    required this.resultados,
    required this.paginas,
  });

  List<Resultado> resultados;
  int paginas;

  factory ServicesDto.fromJson(Map<String, dynamic> json) => ServicesDto(
        resultados: List<Resultado>.from(
            json["resultados"].map((x) => Resultado.fromJson(x))),
        paginas: json["paginas"],
      );

  Map<String, dynamic> toJson() => {
        "resultados": List<dynamic>.from(resultados.map((x) => x.toJson())),
        "paginas": paginas,
      };
}

class Resultado {
  Resultado({
    required this.index,
    required this.type,
    required this.id,
    required this.score,
    required this.sort,
    required this.doc,
  });

  Index? index;
  Type? type;
  String id;
  dynamic score;
  List<int> sort;
  Doc doc;

  factory Resultado.fromJson(Map<String, dynamic> json) => Resultado(
        index: indexValues.map[json["_index"]],
        type: typeValues.map[json["_type"]],
        id: json["_id"],
        score: json["_score"],
        sort: List<int>.from(json["sort"].map((x) => x)),
        doc: Doc.fromJson(json["doc"]),
      );

  Map<String, dynamic> toJson() => {
        "_index": indexValues.reverse[index],
        "_type": typeValues.reverse[type],
        "_id": id,
        "_score": score,
        "sort": List<dynamic>.from(sort.map((x) => x)),
        "doc": doc.toJson(),
      };
}

class Doc {
  Doc({
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

  Service toDomain() {
    return Service(
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

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
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

enum Index { SERVICIOCOMUNIDADS }

final indexValues =
    EnumValues({"serviciocomunidads": Index.SERVICIOCOMUNIDADS});

enum Type { SERVICIO_COMUNIDAD }

final typeValues = EnumValues({"servicioComunidad": Type.SERVICIO_COMUNIDAD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
