part of 'create_publication_bloc.dart';

@immutable
abstract class CreatePublicationEvent {}

class CreatePublication extends CreatePublicationEvent {
  final CreatePublicationFormEntity createForm;

  CreatePublication(this.createForm);
}
