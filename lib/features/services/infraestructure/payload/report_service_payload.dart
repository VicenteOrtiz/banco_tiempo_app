// To parse this JSON data, do
//
//     final reportServicePayload = reportServicePayloadFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ReportServicePayload reportServicePayloadFromJson(String str) =>
    ReportServicePayload.fromJson(json.decode(str));

String reportServicePayloadToJson(ReportServicePayload data) =>
    json.encode(data.toJson());

class ReportServicePayload {
  ReportServicePayload({
    required this.servicioId,
    required this.razon,
  });

  String servicioId;
  String razon;

  factory ReportServicePayload.fromJson(Map<String, dynamic> json) =>
      ReportServicePayload(
        servicioId: json["servicioID"],
        razon: json["razon"],
      );

  Map<String, dynamic> toJson() => {
        "servicioID": servicioId,
        "razon": razon,
      };
}
