import 'dart:convert';

import '../../../my_services/infraestructure/models/pending_services_dto.dart';

PendingMessagesDto pendingMessagesDtoFromJson(String str) =>
    PendingMessagesDto.fromJson(json.decode(str));

String pendingMessagesDtoToJson(PendingMessagesDto data) =>
    json.encode(data.toJson());

class PendingMessagesDto {
  PendingMessagesDto({
    required this.servicios,
  });

  List<RequestedServiceDto> servicios;

  factory PendingMessagesDto.fromJson(Map<String, dynamic> json) =>
      PendingMessagesDto(
        servicios: List<RequestedServiceDto>.from(
            json["servicios"].map((x) => RequestedServiceDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "servicios": List<dynamic>.from(servicios.map((x) => x.toJson())),
      };
}
