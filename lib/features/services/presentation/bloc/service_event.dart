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

class RequestService extends ServiceEvent {
  final Service? service;
  RequestService({this.service});
}

class ReportService extends ServiceEvent {
  final ReportServicePayload reportServicePayload;

  ReportService(this.reportServicePayload);
}

class CommentService extends ServiceEvent {
  final CommentServicePayload commentServicePayload;

  CommentService(this.commentServicePayload);
}
