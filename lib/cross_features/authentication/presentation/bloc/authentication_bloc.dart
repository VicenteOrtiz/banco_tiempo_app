import 'package:banco_tiempo_app/core/config/services/secure_storage.dart';
import 'package:banco_tiempo_app/cross_features/authentication/domain/login_user_entity.dart';
import 'package:banco_tiempo_app/cross_features/authentication/infrastructure/authentication_repository.dart';
import 'package:banco_tiempo_app/cross_features/authentication/infrastructure/models/login_response_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    final AuthenticationRepository _authenticationRepository =
        AuthenticationRepository();

    final StorageService _storageService = StorageService();

    on<Login>(
      ((event, emit) async {
        LoginUserEntity loginUserEntity = LoginUserEntity();
        if (event.username.isEmpty || event.password.isEmpty) {
          emit(AuthenticationError("Ingrese datos válidos porfavor."));
        } else {
          emit(AuthenticationLoading());
          loginUserEntity.username = event.username;
          loginUserEntity.password = event.password;
          final loginResponse =
              await _authenticationRepository.logIn(loginUserEntity);
          if (loginResponse.error == null) {
            _storageService.setToken(loginResponse.token!);
            //HAY QUE IR A BUSCAR USERDETAILS
            final userDetails = await _authenticationRepository
                .getUserDetails("Bearer ${loginResponse.token!}");
            emit(AuthenticationLoaded(
              event.username,
              userDetails.admin,
              userDetails.balance,
              userDetails.imagenUrl,
              userDetails.notificaciones,
            ));
          } else {
            emit(AuthenticationError(loginResponse.error));
          }
        }
      }),
    );

    on<Initialize>(
      ((event, emit) {
        print("Se inicializo");
        emit(AuthenticationInitial());
      }),
    );

    /*  on<AuthenticationEvent>((event, emit) async {
      // TODO: implement event handler
      LoginUserEntity loginUserEntity = LoginUserEntity();
      if (event is Login) {
        if (event.username.isEmpty || event.password.isEmpty) {
          emit(AuthenticationError("Ingrese datos válidos porfavor."));
        } else {
          emit(AuthenticationLoading());
          loginUserEntity.username = event.username;
          loginUserEntity.password = event.password;
          final loginResponse =
              await _authenticationRepository.logIn(loginUserEntity);
          if (loginResponse.error == null) {
            _storageService.setToken(loginResponse.token!);
            emit(AuthenticationLoaded(event.username));
          } else {
            emit(AuthenticationError(loginResponse.error));
          }
        }
      } else if (event is Initialize) {
        print("Se inicializo");
        emit(AuthenticationInitial());
      }
    }); */
  }
}
