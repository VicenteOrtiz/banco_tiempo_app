import 'package:banco_tiempo_app/core/config/services/secure_storage.dart';
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
}
