import 'datasource/profile_datasource.dart';
import 'models/profile_dto.dart';

import '../domain/profile_entity.dart';

class ProfileRepository {
  final _datasource = ProfileDataSource();

  Future<Profile?> getProfile() async =>
      await _datasource.getProfile().then((value) {
        if (value == null) {
          return null;
        } else {
          return value.toDomain();
        }
      });
  //return _datasource.getProfile();

}
