part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {}

class GetPendingMessages extends MessagesEvent {}
