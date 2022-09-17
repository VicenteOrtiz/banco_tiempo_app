import 'package:banco_tiempo_app/core/config/services/secure_storage.dart';
import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:banco_tiempo_app/features/services/infraestructure/payload/service_payload.dart';
import 'package:banco_tiempo_app/features/services/infraestructure/service_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/service_entity.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    ServicesRepository _servicesRepository = ServicesRepository();

    on<GetServices>((event, emit) async {
      emit(ServiceLoading());
      ServicePayload servicePayload;

      if (event.servicePayload == null) {
        StorageService _storageService = StorageService();
        String? usuarioId = await _storageService.getUserId();
        servicePayload = ServicePayload(
            categorias: [],
            pagina: 0,
            query: "",
            size: 10,
            usuarioId: usuarioId!);
      } else {
        servicePayload = event.servicePayload!;
      }
      final List<Service>? newServices =
          await _servicesRepository.getServices(servicePayload);

      if (newServices == null) {
        emit(ServiceError());
      } else {
        emit(ServiceLoaded(newServices));
      }
    });
  }
}
