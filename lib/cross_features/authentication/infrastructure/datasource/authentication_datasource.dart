import 'dart:convert';

import 'package:banco_tiempo_app/features/registration/domain/registration_form_entity.dart';

import '../../domain/login_user_entity.dart';
import '../models/user_details_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../../core/config/services/secure_storage.dart';
import '../../../../secrets.dart';
import '../models/login_response_dto.dart';

class AuthenticationDatasource {
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

  Future<bool> register(RegistrationForm registerForm) async {
    var url = Uri.https(baseUrl, "/api/registrar");
    print(registerForm.toJson());
    print("ALGO PASA ACA");
    try {
      print("ENTRA AL TRY");
      var response = await http.post(
        url,
        body: registerForm.toJson(),
      );
      print("SALIO DEL RESPONSE");
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        print("200");
        return true;
        //return LoginResponseDto.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        print(response.body);
        return false;
        //return LoginResponseDto.withError("Correo/Contraseña incorrecto.");
      } else {
        print(response.body);
        return false;
        //return LoginResponseDto.withError("HUBO UN ERROR NO RECONOCIDO");
      }
    } catch (e, s) {
      print(e);
      print(s);
      return false;
      //return LoginResponseDto.withError(e.toString());
    }
  }

  Future<bool> recoverPassword(String mail) async {
    var url = Uri.https(baseUrl, "/api/recuperarPassword");
    try {
      var response = await http.post(
        url,
        body: {
          "email": mail,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      print("$e $s");
      return false;
    }
  }
}
