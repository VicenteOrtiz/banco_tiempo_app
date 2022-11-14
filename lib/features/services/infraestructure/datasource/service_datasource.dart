import 'dart:convert';

import '../../../../core/config/services/secure_storage.dart';
import '../payload/service_payload.dart';
import '../../../../secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../domain/service_entity.dart';
import '../models/service_dto.dart';

class ServiceDataSource {
  StorageService _storageService = StorageService();

  Future<ServicesDto?> getServices(ServicePayload servicePayload) async {
    var url = Uri.https(baseUrl, "/api/busquedaServicios");
    var token = await _storageService.getToken();
    try {
      var response = await http.post(url,
          headers: {
            'Authorization': token!,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(servicePayload.toJson()));
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return ServicesDto.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e, s) {
      return null;
    }
  }

  Future<bool> requestService(Service service) async {
    var url = Uri.https(baseUrl, "/api/solicitarServicio");
    var token = await _storageService.getToken();
    Map<String, dynamic> requestBody = {
      "servicioID": service.id,
    };
    try {
      var response = await http.post(
        url,
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
