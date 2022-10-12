part of 'publication_bloc.dart';

@immutable
abstract class PublicationEvent {}

class GetPublications extends PublicationEvent {}

class CreatePublication extends PublicationEvent {}

class HidePublication extends PublicationEvent {
  final String publicationId;

  HidePublication(this.publicationId);
}

class RepublishPublication extends PublicationEvent {
  final String publicationId;

  RepublishPublication(this.publicationId);
}
