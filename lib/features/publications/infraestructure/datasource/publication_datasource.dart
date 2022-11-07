import 'dart:convert';

import 'package:banco_tiempo_app/core/config/services/secure_storage.dart';
import 'package:banco_tiempo_app/features/publications/create/entity/create_publication_form_entity.dart';
import 'package:banco_tiempo_app/features/publications/infraestructure/models/publication_dto.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../../secrets.dart';

class PublicationDataSource {
  StorageService _storageService = StorageService();

  Future<List<PublicationDto>?> getUserPublications() async {
    var url = Uri.https(baseUrl, "/api/serviciosPorUsuario");
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
        /* var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>; */

        return publicationsDtoFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> createPublication(CreatePublicationFormEntity createForm) async {
    var url = Uri.https(baseUrl, "/api/publicar_servicio");
    var token = await _storageService.getToken();

    try {
      var response = await http.post(
        url,
        body: json.encode(createForm.toJson()),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print(s);
      return false;
    }

    //return true;
  }

  Future<bool> hidePublication(String publicationId) async {
    var url = Uri.https(baseUrl, "/api/ocultarServicio");
    var token = await _storageService.getToken();

    Map<String, dynamic> payload = {"servicioID": publicationId};

    try {
      var response = await http.post(
        url,
        body: json.encode(payload),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print(s);
      return false;
    }
  }

  Future<bool> republishPublication(String publicationId) async {
    var url = Uri.https(baseUrl, "/api/republicarServicio");
    var token = await _storageService.getToken();

    Map<String, dynamic> payload = {"servicioID": publicationId};

    try {
      var response = await http.post(
        url,
        body: json.encode(payload),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print(s);
      return false;
    }
  }
}
