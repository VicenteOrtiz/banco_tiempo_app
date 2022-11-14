import 'dart:convert';

ConfirmServicePayload confirmServicePayloadFromJson(String str) =>
    ConfirmServicePayload.fromJson(json.decode(str));

String confirmServicePayloadToJson(ConfirmServicePayload data) =>
    json.encode(data.toJson());

class ConfirmServicePayload {
  ConfirmServicePayload({
    required this.puntaje,
    required this.comentario,
    required this.cualidades,
    required this.transaccionId,
  });

  int puntaje;
  String comentario;
  List<String> cualidades;
  String transaccionId;

  factory ConfirmServicePayload.fromJson(Map<String, dynamic> json) =>
      ConfirmServicePayload(
        puntaje: json["puntaje"],
        comentario: json["comentario"],
        cualidades: List<String>.from(json["cualidades"].map((x) => x)),
        transaccionId: json["transaccionID"],
      );

  Map<String, dynamic> toJson() => {
        "puntaje": puntaje,
        "comentario": comentario,
        "cualidades": List<dynamic>.from(cualidades.map((x) => x)),
        "transaccionID": transaccionId,
      };
}
