import 'dart:convert';

import 'package:banco_tiempo_app/features/settings/domain/edit_profile_entity.dart';

import '../../../../core/config/services/secure_storage.dart';
import '../../../../secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SettingsDatasource {
  StorageService _storageService = StorageService();

  Future<bool> editProfile(EditProfileForm editProfileForm) async {
    var url = Uri.https(baseUrl, "/api/setProfile");
    var token = await _storageService.getToken();
    //print("GETPROFILE - token: ${token}");
    try {
      var response = await http.post(
        url,
        body: json.encode(editProfileForm),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        //print(jsonResponse);
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print(e);
      print(s);
      return false;
    }
  }
}
