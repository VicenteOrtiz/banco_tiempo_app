import 'package:banco_tiempo_app/features/settings/domain/edit_profile_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../infraestructure/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    SettingsRepository _settingsRepository = SettingsRepository();

    on<EditProfile>((event, emit) async {
      // TODO: implement event handler
      print("Se quiere editar el perfil");
      emit(EditingLoading());
      try {
        var editProfile =
            await _settingsRepository.getProfile(event.editProfileForm);
        editProfile ? emit(ProfileEdited()) : emit(SettingsError());
      } catch (e) {
        print(e);
        emit(SettingsError());
      }
    });
  }
}
