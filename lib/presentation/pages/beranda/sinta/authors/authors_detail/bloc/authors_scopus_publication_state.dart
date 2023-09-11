part of 'authors_scopus_publication_bloc.dart';

abstract class AuthorsScopusPublicationState extends Equatable {
  const AuthorsScopusPublicationState();
}

class AuthorsScopusPublicationLoading extends AuthorsScopusPublicationState {
  @override
  List<Object> get props => [];
}

class AuthorsScopusPublicationNotFound extends AuthorsScopusPublicationState {
  @override
  List<Object> get props => [];
}

class AuthorsScopusPublicationNoInternet extends AuthorsScopusPublicationState {
  @override
  List<Object> get props => [];
}

class AuthorsScopusPublicationLoaded extends AuthorsScopusPublicationState {
  final int totalItem;
  final int page;
  final List<Scopus> listScopus;
  final bool hasReachedMax;

  AuthorsScopusPublicationLoaded({
    required this.totalItem,
    required this.page,
    required this.listScopus,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [totalItem, page, listScopus, hasReachedMax];
}
