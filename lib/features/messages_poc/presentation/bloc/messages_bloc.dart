import 'package:banco_tiempo_app/features/messages_poc/infrastructure/messages_repository.dart';
import 'package:banco_tiempo_app/features/messages_poc/infrastructure/models/help_messages_dto.dart';
import 'package:banco_tiempo_app/features/messages_poc/infrastructure/models/messages_dto.dart';
import 'package:banco_tiempo_app/features/messages_poc/infrastructure/models/pending_messages_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesInitial()) {
    MessagesRepository _messagesRepository = MessagesRepository();
    on<GetPendingMessages>(
      (event, emit) async {
        emit(PendingMessagesLoading());

        try {
          PendingMessagesDto? pendingMessages =
              await _messagesRepository.getPendingMessages();
          if (pendingMessages == null) {
            emit(PendingMessagesError());
          } else {
            emit(PendingMessagesLoaded(pendingMessages: pendingMessages));
          }
        } catch (e) {
          emit(PendingMessagesError());
        }
      },
    );

    on<GetMessages>(
      (event, emit) async {
        emit(MessagesLoading());
        try {
          MessagesDto? messages =
              await _messagesRepository.getMessages(event.serviceId);
          if (messages == null) {
            emit(PendingMessagesError());
          } else {
            emit(MessagesLoaded(messages: messages));
          }
        } catch (e) {
          emit(PendingMessagesError());
        }
      },
    );

    on<GetHelpMessages>(
      (event, emit) async {
        emit(MessagesLoading());
        try {
          HelpMessagesDto? helpMessages =
              await _messagesRepository.getHelpMessages();
          if (helpMessages == null) {
            emit(HelpMessagesError());
          } else {
            emit(HelpMessagesLoaded(messages: helpMessages));
          }
        } catch (e) {
          emit(HelpMessagesError());
        }
      },
    );
  }
}
