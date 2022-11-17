import 'package:banco_tiempo_app/features/registration/domain/registration_form_entity.dart';

import '../../../../features/profile/infrastructure/profile_repository.dart';

import '../../../../core/config/services/secure_storage.dart';
import '../../domain/login_user_entity.dart';
import '../../infrastructure/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/shared_preferences/app_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    final AuthenticationRepository _authenticationRepository =
        AuthenticationRepository();

    //TODO: Fix this relationship with profile
    final ProfileRepository _profileRepository = ProfileRepository();

    final StorageService _storageService = StorageService();
    var appPreferences = AppPreferences();

    //TODO: too much dependency between different APIS, they should be fixed.
    on<Login>(
      ((event, emit) async {
        LoginUserEntity loginUserEntity = LoginUserEntity();
        if (event.username.isEmpty || event.password.isEmpty) {
          emit(AuthenticationError("Ingrese datos válidos porfavor."));
        } else {
          emit(AuthenticationLoading());
          loginUserEntity.username = event.username.toLowerCase();
          loginUserEntity.password = event.password;
          final loginResponse =
              await _authenticationRepository.logIn(loginUserEntity);
          if (loginResponse.error == null) {
            _storageService.setToken(loginResponse.token!);
            //HAY QUE IR A BUSCAR USERDETAILS
            final userDetails = await _authenticationRepository
                .getUserDetails("Bearer ${loginResponse.token!}");
            _storageService.setUserId(userDetails.id);
            final userProfile = await _profileRepository.getProfile();
            //print(userProfile!.name);
            appPreferences.isFirstTime = false;
            appPreferences.userName = event.username;
            //print("isFirstTime ${appPreferences.isFirstTime}");
            //TODO: guardar el nombre en vez del username
            emit(AuthenticationLoaded(
              userDetails.id,
              "${userProfile?.name} ${userProfile?.lastName}",
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

    on<Register>(
      (event, emit) async {
        emit(AuthenticationLoading());

        final registration =
            await _authenticationRepository.register(event.registrationForm);

        if (registration) {
          emit(AuthenticationRegistrated());
        } else {
          emit(AuthenticationError("No se pudo registrar"));
        }
      },
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
