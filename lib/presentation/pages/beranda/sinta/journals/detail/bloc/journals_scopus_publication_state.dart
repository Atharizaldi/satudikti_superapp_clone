part of 'journals_scopus_publication_bloc.dart';

abstract class JournalsScopusPublicationState extends Equatable {
  const JournalsScopusPublicationState();
}

class JournalsScopusPublicationLoading extends JournalsScopusPublicationState {
  @override
  List<Object> get props => [];
}

class JournalsScopusPublicationNotFound extends JournalsScopusPublicationState{
  @override
  List<Object> get props => [];
}

class JournalsScopusPublicationNoInternet extends JournalsScopusPublicationState {
  @override
  List<Object> get props => [];
}

class JournalsScopusPublicationLoaded extends JournalsScopusPublicationState {
  final int totalItem;
  final int page;
  final List<Google> list;
  final bool hasReachedMax;

  JournalsScopusPublicationLoaded({
    required this.totalItem,
    required this.page,
    required this.list,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [totalItem, page, list, hasReachedMax];
}
