import 'package:banco_tiempo_app/features/my_services/domain/my_services_entity.dart';
import 'package:banco_tiempo_app/features/my_services/infraestructure/datasource/my_services_datasource.dart';
import 'package:banco_tiempo_app/features/my_services/infraestructure/models/pending_services_dto.dart';

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
}
