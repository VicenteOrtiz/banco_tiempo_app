import 'package:banco_tiempo_app/features/publications/create/entity/create_publication_form_entity.dart';
import 'package:banco_tiempo_app/features/publications/infraestructure/publication_repository.dart';
import 'package:banco_tiempo_app/features/publications/presentation/bloc/publication_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_publication_event.dart';
part 'create_publication_state.dart';

class CreatePublicationBloc
    extends Bloc<CreatePublicationEvent, CreatePublicationState> {
  CreatePublicationBloc() : super(CreatePublicationInitial()) {
    PublicationRepository _repository = PublicationRepository();
    on<CreatePublication>((event, emit) async {
      // TODO: implement event handler
      emit(CreatePublicationLoading());
      print("HOLA");
      print(event.createForm.title);

      try {
        final createPublicationResponse =
            await _repository.createPublication(event.createForm);

        if (createPublicationResponse) {
          emit(CreatePublicationSuccesfull());
        } else {
          emit(CreatePublicationError());
        }
      } catch (e) {
        print(e);
        emit(CreatePublicationError());
      }
    });
  }
}
