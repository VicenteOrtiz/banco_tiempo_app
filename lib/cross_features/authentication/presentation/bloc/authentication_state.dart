part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {
  final bool isLogged;
  final bool isAdmin;
  final String? name;
  final int? balance;
  final String? imageUrl;
  final int? notifications;

  const AuthenticationState(
      {this.isLogged = false,
      this.isAdmin = false,
      this.name,
      this.balance,
      this.imageUrl,
      this.notifications});
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial() : super(isLogged: false, name: null);
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationLoaded extends AuthenticationState {
  final String name;
  final bool isAdmin;
  final int balance;
  final String imageUrl;
  final int notifications;

  AuthenticationLoaded(
      this.name, this.isAdmin, this.balance, this.imageUrl, this.notifications)
      : super(
            name: name,
            isLogged: true,
            isAdmin: isAdmin,
            balance: balance,
            imageUrl: imageUrl,
            notifications: notifications);
}

class AuthenticationError extends AuthenticationState {
  final String? message;
  AuthenticationError(this.message);
}
