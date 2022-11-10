import 'dart:convert';

import '../../../my_services/infraestructure/models/pending_services_dto.dart';
import '../../../my_services/infraestructure/payload/confirm_service_payload.dart';
import '../../../../secrets.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../../core/config/services/secure_storage.dart';
import '../models/pending_messages_dto.dart';

class MessagesDatasource {
  StorageService _storageService = StorageService();

  Future<PendingMessagesDto?> getPendingMessages() async {
    var url = Uri.https(baseUrl, "/api/mensajesPendientes");
    var token = await _storageService.getToken();
    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return PendingMessagesDto.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e, s) {
      print("LLEGO ACA?");
      print(s);
      print(e);
      return null;
    }
  }
}
