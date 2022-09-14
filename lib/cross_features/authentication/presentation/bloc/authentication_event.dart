part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String username;
  final String password;

  Login(this.username, this.password);
}

class Initialize extends AuthenticationEvent {}
