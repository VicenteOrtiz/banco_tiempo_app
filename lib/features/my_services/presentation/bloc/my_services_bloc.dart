import 'package:banco_tiempo_app/features/my_services/domain/my_services_entity.dart';
import 'package:banco_tiempo_app/features/my_services/infraestructure/my_services_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_services_event.dart';
part 'my_services_state.dart';

class MyServicesBloc extends Bloc<MyServicesEvent, MyServicesState> {
  MyServicesBloc() : super(MyServicesInitial()) {
    MyServicesRepository _myServicesRepository = MyServicesRepository();

    on<GetMyServices>(
      (event, emit) async {
        emit(MyServicesLoading());
        try {
          MyServices? myServices = await _myServicesRepository.getServices();
          if (myServices == null) {
            emit(MyServicesError());
          } else {
            emit(MyServicesLoaded(myServices));
          }
        } catch (e) {
          emit(MyServicesError());
        }
      },
    );

    on<CancelService>(
      (event, emit) async {
        print("ENTRA ACA");
        emit(MyServicesCanceling());
        try {
          print("ENTRO EN EL TRY");
          bool isServiceCancelled =
              await _myServicesRepository.cancelService(event.serviceId);
          if (isServiceCancelled) {
            emit(MyServicesCancelled());
          } else {
            print("NO SE PUDO CANCELAR");
          }
        } catch (e) {
          emit(MyServicesError());
        }
      },
    );
  }
}
