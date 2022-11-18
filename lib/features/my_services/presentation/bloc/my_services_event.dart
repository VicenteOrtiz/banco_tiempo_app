part of 'my_services_bloc.dart';

@immutable
abstract class MyServicesEvent {}

class GetMyServices extends MyServicesEvent {}

class CancelService extends MyServicesEvent {
  final String serviceId;

  CancelService({required this.serviceId});
}

class AcceptService extends MyServicesEvent {
  final String serviceId;

  AcceptService({required this.serviceId});
}

class RejectService extends MyServicesEvent {
  final String serviceId;

  RejectService({required this.serviceId});
}

class FinishService extends MyServicesEvent {
  final ConfirmServicePayload confirmServicePayload;

  FinishService({required this.confirmServicePayload});
}

class GetHistoricServices extends MyServicesEvent {}
