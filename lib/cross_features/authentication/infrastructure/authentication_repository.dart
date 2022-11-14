import 'package:banco_tiempo_app/cross_features/authentication/domain/login_user_entity.dart';
import 'package:banco_tiempo_app/cross_features/authentication/infrastructure/datasource/authentication_datasource.dart';
import 'package:banco_tiempo_app/cross_features/authentication/infrastructure/models/login_response_dto.dart';
import 'package:banco_tiempo_app/cross_features/authentication/infrastructure/models/user_details_dto.dart';
import 'package:flutter/material.dart';

class AuthenticationRepository {
  final _datasource = AuthenticationDatasource();

  Future<LoginResponseDto> logIn(LoginUserEntity loginUserEntity) {
    return _datasource.logIn(loginUserEntity);
  }

  Future<UserDetailsDto> getUserDetails(String token) {
    return _datasource.getUserDetails(token);
  }
}
