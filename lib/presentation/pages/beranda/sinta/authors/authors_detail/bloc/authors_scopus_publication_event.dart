part of 'authors_scopus_publication_bloc.dart';

abstract class AuthorsScopusPublicationEvent extends Equatable {
  const AuthorsScopusPublicationEvent();
}

class GetAuthorsScopusEvent extends AuthorsScopusPublicationEvent {
  final String nidn;

  GetAuthorsScopusEvent({required this.nidn});

  @override
  List<Object> get props => [nidn];
}