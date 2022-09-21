part of 'service_bloc.dart';

@immutable
abstract class ServiceEvent {}

class GetServices extends ServiceEvent {
  final ServicePayload? servicePayload;

  GetServices({this.servicePayload});
}

class RefreshServices extends ServiceEvent {}

class FilterServices extends ServiceEvent {
  final ServicePayload? servicePayload;

  FilterServices({this.servicePayload});
}
