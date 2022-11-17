import 'package:banco_tiempo_app/cross_features/public_profile/domain/public_profile.dart';

import 'datasource/public_profile_datasource.dart';

class PublicProfileRepository {
  final _datasource = PublicProfileDataSource();

  Future<PublicProfile?> getProfile() async =>
      await _datasource.getPublicProfile().then((value) {
        if (value == null) {
          return null;
        } else {
          return value.toDomain();
        }
      });
  //return _datasource.getProfile();

}
