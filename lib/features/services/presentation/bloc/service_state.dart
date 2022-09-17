part of 'service_bloc.dart';

@immutable
abstract class ServiceState {
  final int? pages;
  final int actualPage;
  final List<Service>? services;

  const ServiceState({
    this.actualPage = 0,
    this.pages,
    this.services,
  });
}

class ServiceInitial extends ServiceState {
  const ServiceInitial() : super(actualPage: 0);
}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<Service> services;

  ServiceLoaded(this.services);
}

class ServiceError extends ServiceState {}
