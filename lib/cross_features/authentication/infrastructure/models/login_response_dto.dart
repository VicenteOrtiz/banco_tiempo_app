import 'dart:convert';

LoginResponseDto loginResponseFromJson(String str) =>
    LoginResponseDto.fromJson(json.decode(str));

String loginResponseToJson(LoginResponseDto data) => json.encode(data.toJson());

class LoginResponseDto {
  String? token;
  String? error;

  LoginResponseDto({
    this.token,
    this.error,
  });

  LoginResponseDto.withError(String errorMessage) {
    error = errorMessage;
  }

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      LoginResponseDto(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
