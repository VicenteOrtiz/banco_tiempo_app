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

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final MessagesDto messages;
  MessagesLoaded({required this.messages});
}

class HelpMessagesLoading extends MessagesState {}

class HelpMessagesLoaded extends MessagesState {
  final HelpMessagesDto messages;
  HelpMessagesLoaded({required this.messages});
}

class HelpMessagesError extends MessagesState {}
