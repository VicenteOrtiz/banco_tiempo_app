part of 'messages_bloc.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class PendingMessagesLoading extends MessagesState {}

class PendingMessagesLoaded extends MessagesState {
  final PendingMessagesDto pendingMessages;

  PendingMessagesLoaded({required this.pendingMessages});
}

class PendingMessagesError extends MessagesState {}
