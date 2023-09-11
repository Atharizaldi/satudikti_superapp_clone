part of 'sinta_search_bloc.dart';

abstract class SintaSearchState extends Equatable {
  const SintaSearchState();
}

class SintaSearchInitial extends SintaSearchState {
  @override
  List<Object> get props => [];
}

class SintaSearchLoading extends SintaSearchState {
  @override
  List<Object> get props => [];
}

class SintaSearchNoInternet extends SintaSearchState {
  @override
  List<Object> get props => [];
}

class SintaSearchError extends SintaSearchState {
  @override
  List<Object> get props => [];
}

class SintaSearchLoaded extends SintaSearchState {
  final int totalItemAuthors;
  final List<Authors> authorsList;
  final int totalItemAffiliations;
  final List<Affiliations> affiliationsList;
  final int totalItemJournals;
  final List<Journals> journalsList;

  SintaSearchLoaded({
    required this.totalItemAuthors,
    required this.authorsList,
    required this.totalItemAffiliations,
    required this.affiliationsList,
    required this.totalItemJournals,
    required this.journalsList,
  });

  @override
  List<Object> get props => [
        totalItemAuthors,
        authorsList,
        totalItemAffiliations,
        affiliationsList,
        totalItemJournals,
        journalsList,
      ];
}
