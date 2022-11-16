import 'package:banco_tiempo_app/cross_features/public_profile/infraestructure/models/public_profile_dto.dart';

import '../../../../core/config/services/secure_storage.dart';
import '../../../../secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PublicProfileDataSource {
  StorageService _storageService = StorageService();

  Future<PublicProfileDto?> getPublicProfile() async {
    var userId = await _storageService.getUserId();
    var token = await _storageService.getToken();
    var url = Uri.https(baseUrl, "/api/perfilPublico/$userId");
    //print("GETPROFILE - token: ${token}");
    try {
      print(userId);
      var response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        //print(jsonResponse);
        return PublicProfileDto.fromJson(jsonResponse);
      } else {
        print(response.statusCode);
        print(response.body);
        print(response);
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }
}
