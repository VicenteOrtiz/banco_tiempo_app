import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/profile_entity.dart';
import '../../infrastructure/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    ProfileRepository _profileRepository = ProfileRepository();

    on<GetProfile>((event, emit) async {
      emit(ProfileLoading());

      final Profile? profile = await _profileRepository.getProfile();

      if (profile == null) {
        emit(ProfileError());
      } else {
        emit(ProfileLoaded(profile));
      }
    });
  }
}
