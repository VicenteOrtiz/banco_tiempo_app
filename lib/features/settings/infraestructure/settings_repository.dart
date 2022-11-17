import 'package:banco_tiempo_app/features/settings/domain/edit_profile_entity.dart';
import 'package:banco_tiempo_app/features/settings/infraestructure/datasource/settings_datasource.dart';
import 'package:banco_tiempo_app/features/settings/infraestructure/payload/change_password_payload.dart';

class SettingsRepository {
  final _datasource = SettingsDatasource();

  Future<bool> getProfile(EditProfileForm editProfileForm) async =>
      await _datasource.editProfile(editProfileForm);
  //return _datasource.getProfile();

  Future<String> changePassword(
          ChangePasswordPayload changePasswordPayload) async =>
      await _datasource.changePassword(changePasswordPayload);
}
