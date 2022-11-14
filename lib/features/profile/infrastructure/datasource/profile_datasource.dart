import '../../../../core/config/services/secure_storage.dart';
import '../models/profile_dto.dart';
import '../../../../secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProfileDataSource {
  StorageService _storageService = StorageService();

  Future<ProfileDto?> getProfile() async {
    var url = Uri.https(baseUrl, "/api/profile");
    var token = await _storageService.getToken();
    //print("GETPROFILE - token: ${token}");
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
        //print(jsonResponse);
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
