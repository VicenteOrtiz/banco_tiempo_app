part of 'my_services_bloc.dart';

@immutable
abstract class MyServicesState {}

class MyServicesInitial extends MyServicesState {}

class MyServicesLoading extends MyServicesState {}

class MyServicesCanceling extends MyServicesState {}

class MyServicesCancelled extends MyServicesState {}

class MyServicesAccepting extends MyServicesState {}

class MyServicesAccepted extends MyServicesState {}

class MyServicesRejecting extends MyServicesState {}

class MyServicesRejected extends MyServicesState {}

class MyServicesFinishing extends MyServicesState {}

class MyServicesFinished extends MyServicesState {}

class MyServicesLoaded extends MyServicesState {
  final MyServices myServices;

  MyServicesLoaded(this.myServices);
}

class MyServicesError extends MyServicesState {}
