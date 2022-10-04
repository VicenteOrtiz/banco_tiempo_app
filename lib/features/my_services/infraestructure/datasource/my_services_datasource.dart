import 'dart:convert';

import 'package:banco_tiempo_app/features/my_services/infraestructure/models/pending_services_dto.dart';
import 'package:banco_tiempo_app/secrets.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../../core/config/services/secure_storage.dart';

class MyServicesDataSource {
  StorageService _storageService = StorageService();

  Future<PendingServicesDto?> getMyServices() async {
    var url = Uri.https(baseUrl, "/api/serviciosPendientes");
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
        return PendingServicesDto.fromJson(jsonResponse);
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

  Future<bool> cancelService(String serviceId) async {
    var url = Uri.https(baseUrl, "/api/cancelar_servicio");
    var token = await _storageService.getToken();
    Map<String, dynamic> payload = {"transaccionID": serviceId};
    try {
      var response = await http.post(url,
          headers: {
            'Authorization': token!,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(payload));
      if (response.statusCode == 200) {
        print("RETORNO TRUE");
        return true;
      } else {
        print("RETORNO FALSE");
        return false;
      }
    } catch (e) {
      print("NO SE PUDO CANCELAR: $e");
      return false;
    }
  }
}
