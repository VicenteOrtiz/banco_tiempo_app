part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class EditProfile extends SettingsEvent {
  final EditProfileForm editProfileForm;

  EditProfile(this.editProfileForm);
}

class EditContact extends SettingsEvent {}

class EditPassword extends SettingsEvent {
  final ChangePasswordPayload changePasswordPayload;

  EditPassword(this.changePasswordPayload);
}
