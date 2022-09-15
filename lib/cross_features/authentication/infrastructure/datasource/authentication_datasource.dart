import 'package:banco_tiempo_app/cross_features/authentication/domain/login_user_entity.dart';
import 'package:banco_tiempo_app/cross_features/authentication/infrastructure/models/user_details_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../../core/config/services/secure_storage.dart';
import '../models/login_response_dto.dart';

class AuthenticationDatasource {
  final String baseUrl = 'bancotiempo.cl';

  Future<LoginResponseDto> logIn(LoginUserEntity loginUserEntity) async {
    var url = Uri.https(baseUrl, "/api/login");
    try {
      var response = await http.post(url, body: loginUserEntity.toJson());
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return LoginResponseDto.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        return LoginResponseDto.withError("Correo/Contraseña incorrecto.");
      } else {
        return LoginResponseDto.withError("HUBO UN ERROR NO RECONOCIDO");
      }
    } catch (e, s) {
      return LoginResponseDto.withError(e.toString());
    }
  }

  Future<UserDetailsDto> getUserDetails(String token) async {
    var url = Uri.https(baseUrl, "/api/userData");
    try {
      var response = await http.post(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      return UserDetailsDto.fromJson(jsonResponse);
    } catch (e, s) {
      print("$e $s");
      return UserDetailsDto.withError(e.toString());
    }
  }
}
