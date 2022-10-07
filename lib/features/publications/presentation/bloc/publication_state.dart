part of 'publication_bloc.dart';

@immutable
abstract class PublicationState {}

class PublicationInitial extends PublicationState {}

class PublicationLoading extends PublicationState {}

class PublicationLoaded extends PublicationState {
  final List<Publication> publications;

  PublicationLoaded(this.publications);
}

class PublicationError extends PublicationState {}
