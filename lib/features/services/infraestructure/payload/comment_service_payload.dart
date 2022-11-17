// To parse this JSON data, do
//
//     final commentServicePayload = commentServicePayloadFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CommentServicePayload commentServicePayloadFromJson(String str) =>
    CommentServicePayload.fromJson(json.decode(str));

String commentServicePayloadToJson(CommentServicePayload data) =>
    json.encode(data.toJson());

class CommentServicePayload {
  CommentServicePayload({
    required this.servicioId,
    required this.texto,
  });

  String servicioId;
  String texto;

  factory CommentServicePayload.fromJson(Map<String, dynamic> json) =>
      CommentServicePayload(
        servicioId: json["servicioID"],
        texto: json["texto"],
      );

  Map<String, dynamic> toJson() => {
        "servicioID": servicioId,
        "texto": texto,
      };
}
