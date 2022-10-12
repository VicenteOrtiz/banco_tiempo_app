part of 'create_publication_bloc.dart';

@immutable
abstract class CreatePublicationState {
  final CreatePublicationFormEntity? createForm;

  const CreatePublicationState({this.createForm});
}

class CreatePublicationInitial extends CreatePublicationState {
  CreatePublicationInitial()
      : super(createForm: CreatePublicationFormEntity.initial());
}

class CreatePublicationLoading extends CreatePublicationState {}

class CreatePublicationError extends CreatePublicationState {}

class CreatePublicationSuccesfull extends CreatePublicationState {}
