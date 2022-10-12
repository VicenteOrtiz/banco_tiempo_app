part of 'publication_bloc.dart';

@immutable
abstract class PublicationState {}

class PublicationInitial extends PublicationState {}

class PublicationLoading extends PublicationState {}

class PublicationLoaded extends PublicationState {
  final List<Publication> publications;
  final List<Publication> hiddenPublications;

  PublicationLoaded(this.publications, this.hiddenPublications);
}

class PublicationHiding extends PublicationState {}

class PublicationHidden extends PublicationState {}

class PublicationRepublishing extends PublicationState {}

class PublicationRepublished extends PublicationState {}

class PublicationError extends PublicationState {}
