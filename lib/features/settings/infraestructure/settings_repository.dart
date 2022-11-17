import 'package:banco_tiempo_app/features/settings/domain/edit_profile_entity.dart';
import 'package:banco_tiempo_app/features/settings/infraestructure/datasource/settings_datasource.dart';

class SettingsRepository {
  final _datasource = SettingsDatasource();

  Future<bool> getProfile(EditProfileForm editProfileForm) async =>
      await _datasource.editProfile(editProfileForm);
  //return _datasource.getProfile();

}
