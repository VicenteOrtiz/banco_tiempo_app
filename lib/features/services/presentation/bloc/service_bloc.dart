import 'package:banco_tiempo_app/features/services/infraestructure/payload/comment_service_payload.dart';
import 'package:banco_tiempo_app/features/services/infraestructure/payload/report_service_payload.dart';

import '../../../../core/config/services/secure_storage.dart';
import '../../../../cross_features/category/domain/category_entity.dart';
import '../../infraestructure/payload/service_payload.dart';
import '../../infraestructure/service_repository.dart';
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

    on<RequestService>((event, emit) async {});

    on<ReportService>(
      (event, emit) async {
        emit(ServiceLoading());

        try {
          var reportService = await _servicesRepository
              .reportService(event.reportServicePayload);

          if (reportService) {
            emit(ServiceReported());
          } else {
            emit(ServiceError());
          }
        } catch (e) {
          emit(ServiceError());
        }
      },
    );

    on<CommentService>(
      (event, emit) async {
        emit(ServiceLoading());

        try {
          var commentService = await _servicesRepository
              .commentService(event.commentServicePayload);

          if (commentService) {
            emit(ServiceCommented());
          } else {
            emit(ServiceError());
          }
        } catch (e) {
          emit(ServiceError());
        }
      },
    );
  }
}
