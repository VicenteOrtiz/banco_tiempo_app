import 'package:banco_tiempo_app/features/publications/infraestructure/publication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/publication_entity.dart';

part 'publication_event.dart';
part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  PublicationBloc() : super(PublicationInitial()) {
    PublicationRepository _publicationRepository = PublicationRepository();
    List<Publication> publications;

    on<GetPublications>((event, emit) async {
      emit(PublicationLoading());

      final List<Publication>? publicationsResponse =
          await _publicationRepository.getUserPublications();

      if (publicationsResponse == null || publicationsResponse.isEmpty) {
        emit(PublicationError());
      } else {
        publications = publicationsResponse;
        emit(PublicationLoaded(publications));
      }
    });
  }
}
