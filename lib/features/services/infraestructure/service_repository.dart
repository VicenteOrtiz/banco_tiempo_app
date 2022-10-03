import 'package:banco_tiempo_app/features/services/infraestructure/datasource/service_datasource.dart';
import 'package:banco_tiempo_app/features/services/infraestructure/payload/service_payload.dart';

import '../domain/service_entity.dart';
import 'models/service_dto.dart';

class ServicesRepository {
  final _datasource = ServiceDataSource();

  Future<List<Service>?> getServices(ServicePayload servicePayload) async {
    ServicesDto? servicesDto = await _datasource.getServices(servicePayload);

    if (servicesDto == null) {
      return null;
    }
    List<Service> services = [];

    servicesDto.resultados.forEach((service) {
      services.add(service.doc.toDomain());
    });

    return services;
  }

  Future<bool> requestServices(Service service) async {
    bool isServiceRequested = await _datasource.requestService(service);
    return isServiceRequested;
  }
}
