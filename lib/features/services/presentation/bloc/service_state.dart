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
  final bool hasReachedMax;
  final List<Service> services;
  final int actualPage;

  ServiceLoaded(this.services, this.hasReachedMax, this.actualPage)
      : super(actualPage: actualPage);

  ServiceLoaded copyWith(
      {List<Service>? services, bool? hasReachedMax, int? actualPage}) {
    return ServiceLoaded(
      services!,
      hasReachedMax!,
      actualPage!,
    );
  }
}

class ServiceError extends ServiceState {}
