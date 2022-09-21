import 'package:banco_tiempo_app/core/config/services/secure_storage.dart';
import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:banco_tiempo_app/features/services/infraestructure/payload/service_payload.dart';
import 'package:banco_tiempo_app/features/services/infraestructure/service_repository.dart';
import 'package:banco_tiempo_app/features/services/presentation/controller/service_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/service_entity.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    ServicesRepository _servicesRepository = ServicesRepository();

    on<GetServices>((event, emit) async {
      //print("HOLA");
      emit(ServiceLoading());
      ServicePayload servicePayload;
      StorageService _storageService = StorageService();

      if (event.servicePayload == null) {
        String? usuarioId = await _storageService.getUserId();
        servicePayload = ServicePayload(
            categorias: [],
            pagina: 0,
            query: "",
            size: 10,
            usuarioId: usuarioId!);
      } else {
        servicePayload = event.servicePayload!;
        servicePayload.size = 10;
        servicePayload.usuarioId = await _storageService.getUserId();
      }

      final List<Service>? newServices =
          await _servicesRepository.getServices(servicePayload);
      //print(newServices);

      if (newServices == null) {
        emit(ServiceError());
      } else {
        if (event.serviceController == null) {
          ServiceController serviceController = ServiceController(
            0,
            1,
            newServices,
          );
          emit(ServiceLoaded(serviceController));
        } else {
          List<Service> servicesList = [
            ...event.serviceController!.services,
            ...newServices
          ];

          ServiceController serviceController = ServiceController(
            0,
            event.serviceController!.actualPage + 1,
            servicesList,
          );

          emit(ServiceLoaded(serviceController));
        }
      }
    });
  }
}
