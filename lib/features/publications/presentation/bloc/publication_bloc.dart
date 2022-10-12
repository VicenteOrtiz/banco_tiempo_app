import 'package:banco_tiempo_app/features/publications/create/entity/create_publication_form_entity.dart';
import 'package:banco_tiempo_app/features/publications/infraestructure/publication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/publication_entity.dart';

part 'publication_event.dart';
part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  PublicationBloc() : super(PublicationInitial()) {
    PublicationRepository _publicationRepository = PublicationRepository();
    List<Publication> publications = [];
    List<Publication> hiddenPublications = [];

    on<GetPublications>((event, emit) async {
      emit(PublicationLoading());

      publications = [];
      hiddenPublications = [];

      final List<Publication>? publicationsResponse =
          await _publicationRepository.getUserPublications();

      if (publicationsResponse == null || publicationsResponse.isEmpty) {
        emit(PublicationError());
      } else {
        publicationsResponse.forEach((publication) {
          if (publication.oculta)
            hiddenPublications.add(publication);
          else
            publications.add(publication);
        });
        //publications = publicationsResponse;
        emit(PublicationLoaded(publications, hiddenPublications));
      }
    });

    on<HidePublication>(
      (event, emit) async {
        emit(PublicationHiding());

        try {
          final bool hidePublicationResponse =
              await _publicationRepository.hidePublication(event.publicationId);

          hidePublicationResponse
              ? emit(PublicationHidden())
              : emit(PublicationError());
        } catch (e) {
          emit(PublicationError());
        }
      },
    );

    on<RepublishPublication>(
      (event, emit) async {
        emit(PublicationRepublishing());
        try {
          final bool republishPublicationResponse = await _publicationRepository
              .republishPublication(event.publicationId);

          republishPublicationResponse
              ? emit(PublicationRepublished())
              : emit(PublicationError());
        } catch (e) {
          emit(PublicationError());
        }
      },
    );
  }
}
