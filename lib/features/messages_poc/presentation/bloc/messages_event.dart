part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {}

class GetPendingMessages extends MessagesEvent {}

class GetMessages extends MessagesEvent {
  final String serviceId;
  GetMessages({required this.serviceId});
}

class GetHelpMessages extends MessagesEvent {}
