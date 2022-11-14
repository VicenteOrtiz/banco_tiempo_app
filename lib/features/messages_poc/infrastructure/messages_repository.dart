import 'datasource/messages_datasource.dart';
import 'models/messages_dto.dart';
import 'models/pending_messages_dto.dart';
import '../../my_services/domain/my_services_entity.dart';
import '../../my_services/infraestructure/datasource/my_services_datasource.dart';
import '../../my_services/infraestructure/models/pending_services_dto.dart';

class MessagesRepository {
  final _datasource = MessagesDatasource();

  Future<PendingMessagesDto?> getPendingMessages() async {
    PendingMessagesDto? pendingMessages =
        await _datasource.getPendingMessages();

    if (pendingMessages == null) {
      return null;
    } else {
      /* MyServices myServices = MyServices(
          porConfirmar: pendingMessages.porConfirmar,
          solicitado: pendingMessages.solicitado);
      return myServices; */
      return pendingMessages;
    }
  }

  Future<MessagesDto?> getMessages(String id) async {
    MessagesDto? messages = await _datasource.getMessages(id);

    if (messages == null) {
      return null;
    } else {
      return messages;
    }
  }
}