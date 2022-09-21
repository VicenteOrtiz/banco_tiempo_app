part of 'service_bloc.dart';

@immutable
abstract class ServiceEvent {}

class GetServices extends ServiceEvent {
  final ServicePayload? servicePayload;
  final ServiceController? serviceController;

  GetServices({this.servicePayload, this.serviceController});
}
