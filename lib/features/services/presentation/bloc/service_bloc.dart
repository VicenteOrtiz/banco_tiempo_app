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
    //erviceBloc _bloc = ServiceBloc();
    List<Service>? services;
    ServicePayload servicePayload;
    StorageService _storageService = StorageService();

    on<RefreshServices>((event, emit) async {
      try {
        String? usuarioId = await _storageService.getUserId();
        servicePayload = ServicePayload(
            categorias: [],
            pagina: 0,
            query: "",
            size: 10,
            usuarioId: usuarioId!);

        services = await _servicesRepository.getServices(servicePayload);
        if (services == null) {
          emit(ServiceError());
        } else {
          emit(ServiceLoaded(services!, false, state.actualPage + 1));
        }
      } catch (e, s) {
        emit(ServiceError());
      }
    });

    on<FilterServices>((event, emit) async {
      try {
        String? usuarioId = await _storageService.getUserId();
        servicePayload = event.servicePayload!;
        servicePayload.size = 10;
        servicePayload.usuarioId = usuarioId!;

        services = await _servicesRepository.getServices(servicePayload);
        if (services == null) {
          emit(ServiceError());
        } else {
          emit(ServiceLoaded(services!, false, 1));
        }
      } catch (e, s) {
        emit(ServiceError());
      }
    });

    on<GetServices>((event, emit) async {
      //emit(ServiceLoading());
      //ServicePayload servicePayload;
      String? usuarioId = await _storageService.getUserId();
      ServiceLoaded serviceLoaded = state as ServiceLoaded;

      servicePayload = event.servicePayload!;
      servicePayload.size = 20;
      servicePayload.usuarioId = usuarioId;

      final List<Service>? newServices =
          await _servicesRepository.getServices(servicePayload);

      if (newServices == null) {
        emit(ServiceError());
      } else {
        if (newServices.isEmpty) {
          emit(serviceLoaded.copyWith(
              hasReachedMax: true,
              services: serviceLoaded.services,
              actualPage: serviceLoaded.actualPage));
        } else {
          emit(serviceLoaded.copyWith(
              services: serviceLoaded.services + newServices,
              hasReachedMax: false,
              actualPage: servicePayload.pagina + 1));
        }
      }
    });
  }
}
