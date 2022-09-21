part of 'service_bloc.dart';

@immutable
abstract class ServiceState {
  final ServiceController? serviceController;

  const ServiceState({
    this.serviceController,
  });
}

class ServiceInitial extends ServiceState {
  const ServiceInitial()
      : super(serviceController: const ServiceController(0, 0, []));
}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final ServiceController newState;

  ServiceLoaded(this.newState) : super(serviceController: newState);
}

class ServiceError extends ServiceState {}
