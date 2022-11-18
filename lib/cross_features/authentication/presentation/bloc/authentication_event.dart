part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String username;
  final String password;

  Login(this.username, this.password);
}

class Register extends AuthenticationEvent {
  final RegistrationForm registrationForm;

  Register(this.registrationForm);
}

class Initialize extends AuthenticationEvent {}

class RecoverPassword extends AuthenticationEvent {
  final String mail;

  RecoverPassword(this.mail);
}
