import 'package:banco_tiempo_app/core/config/services/secure_storage.dart';
import 'package:banco_tiempo_app/features/profile/infrastructure/models/profile_dto.dart';
import 'package:banco_tiempo_app/secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProfileDataSource {
  StorageService _storageService = StorageService();

  Future<ProfileDto?> getProfile() async {
    var url = Uri.https(baseUrl, "/api/profile");
    var token = await _storageService.getToken();
    print("GETPROFILE - token: ${token}");
    try {
      print(token);
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
        return ProfileDto.fromJson(jsonResponse);
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
