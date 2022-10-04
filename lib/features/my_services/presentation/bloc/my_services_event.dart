part of 'my_services_bloc.dart';

@immutable
abstract class MyServicesEvent {}

class GetMyServices extends MyServicesEvent {}

class CancelService extends MyServicesEvent {
  final String serviceId;

  CancelService({required this.serviceId});
}
