import 'package:banco_tiempo_app/features/publications/infraestructure/datasource/publication_datasource.dart';
import 'package:banco_tiempo_app/features/publications/infraestructure/models/publication_dto.dart';

import '../domain/publication_entity.dart';

class PublicationRepository {
  final _datasource = PublicationDataSource();

  Future<List<Publication>?> getUserPublications() async {
    List<PublicationDto>? publicationsDto =
        await _datasource.getUserPublications();

    if (publicationsDto == null) {
      return null;
    }

    List<Publication> publications = [];

    publicationsDto.forEach((publication) {
      publications.add(publication.toDomain());
    });
    return publications;
  }
}
