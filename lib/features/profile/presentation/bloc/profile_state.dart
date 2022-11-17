part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  final PublicProfile publicProfile;
  ProfileLoaded(this.profile, this.publicProfile);
}

class ProfileError extends ProfileState {}
