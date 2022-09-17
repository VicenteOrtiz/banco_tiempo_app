import 'dart:convert';

ServicePayload servicePayloadFromJson(String str) =>
    ServicePayload.fromJson(json.decode(str));

String servicePayloadToJson(ServicePayload data) => json.encode(data.toJson());

class ServicePayload {
  ServicePayload({
    required this.categorias,
    required this.pagina,
    required this.query,
    required this.size,
    required this.usuarioId,
  });

  List<String> categorias;
  int pagina;
  String query;
  int size;
  String usuarioId;

  factory ServicePayload.fromJson(Map<String, dynamic> json) => ServicePayload(
        categorias: List<String>.from(json["categorias"].map((x) => x)),
        pagina: json["pagina"],
        query: json["query"],
        size: json["size"],
        usuarioId: json["usuarioID"],
      );

  Map<String, dynamic> toJson() => {
        "categorias": List<dynamic>.from(categorias.map((x) => x)),
        "pagina": pagina,
        "query": query,
        "size": size,
        "usuarioID": usuarioId,
      };
}
