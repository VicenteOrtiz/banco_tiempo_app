part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class EditingLoading extends SettingsState {}

class ProfileEditing extends SettingsState {}

class ProfileEdited extends SettingsState {}

class ContactEditing extends SettingsState {}

class ContactEdited extends SettingsState {}

class SettingsError extends SettingsState {
  final String error;

  SettingsError(this.error);
}

class PasswordChanging extends SettingsState {}

class PasswordChanged extends SettingsState {}
