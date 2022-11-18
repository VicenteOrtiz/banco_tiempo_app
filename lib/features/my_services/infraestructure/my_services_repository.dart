import '../domain/my_services_entity.dart';
import 'datasource/my_services_datasource.dart';
import 'models/historic_transactions_dto.dart';
import 'models/pending_services_dto.dart';

import 'payload/confirm_service_payload.dart';

class MyServicesRepository {
  final _datasource = MyServicesDataSource();

  Future<MyServices?> getServices() async {
    PendingServicesDto? pendingServices = await _datasource.getMyServices();

    if (pendingServices == null) {
      return null;
    } else {
      MyServices myServices = MyServices(
          porConfirmar: pendingServices.porConfirmar,
          solicitado: pendingServices.solicitado);
      return myServices;
    }
  }

  Future<bool> cancelService(String serviceId) async =>
      await _datasource.cancelService(serviceId);

  Future<bool> acceptService(String serviceId) async =>
      await _datasource.acceptService(serviceId);

  Future<bool> rejectService(String serviceId) async =>
      await _datasource.rejectService(serviceId);

  Future<bool> finishService(
          ConfirmServicePayload confirmServicePayload) async =>
      await _datasource.finishService(confirmServicePayload);

  Future<List<HistoricTransactionsDto>?> getHistoricTransactions() async =>
      await _datasource.getHistoricTransactions();
}
