part of 'my_services_bloc.dart';

@immutable
abstract class MyServicesState {}

class MyServicesInitial extends MyServicesState {}

class MyServicesLoading extends MyServicesState {}

class MyServicesLoaded extends MyServicesState {
  final MyServices myServices;

  MyServicesLoaded(this.myServices);
}

class MyServicesError extends MyServicesState {}
