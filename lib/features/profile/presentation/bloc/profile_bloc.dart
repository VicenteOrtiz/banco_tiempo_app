import 'package:banco_tiempo_app/cross_features/public_profile/domain/public_profile.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../cross_features/public_profile/infraestructure/public_profile_repository.dart';
import '../../domain/profile_entity.dart';
import '../../infrastructure/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    ProfileRepository _profileRepository = ProfileRepository();
    PublicProfileRepository _publicProfileRepository =
        PublicProfileRepository();

    on<GetProfile>((event, emit) async {
      emit(ProfileLoading());

      final Profile? profile = await _profileRepository.getProfile();
      final PublicProfile? publicProfile =
          await _publicProfileRepository.getProfile();

      if (profile == null || publicProfile == null) {
        emit(ProfileError());
      } else {
        emit(ProfileLoaded(profile, publicProfile));
      }
    });
  }
}
