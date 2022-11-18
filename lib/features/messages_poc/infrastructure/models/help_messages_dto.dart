// To parse this JSON data, do
//
//     final helpMessagesDto = helpMessagesDtoFromJson(jsonString);

import 'package:banco_tiempo_app/features/messages_poc/infrastructure/models/messages_dto.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

HelpMessagesDto helpMessagesDtoFromJson(String str) =>
    HelpMessagesDto.fromJson(json.decode(str));

String helpMessagesDtoToJson(HelpMessagesDto data) =>
    json.encode(data.toJson());

class HelpMessagesDto {
  HelpMessagesDto({
    required this.id,
    required this.mensajesAyuda,
  });

  String id;
  List<Mensaje> mensajesAyuda;

  factory HelpMessagesDto.fromJson(Map<String, dynamic> json) =>
      HelpMessagesDto(
        id: json["_id"],
        mensajesAyuda: List<Mensaje>.from(
                json["mensajesAyuda"].map((x) => Mensaje.fromJson(x)))
            .reversed
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mensajesAyuda":
            List<dynamic>.from(mensajesAyuda.map((x) => x.toJson())),
      };
}
