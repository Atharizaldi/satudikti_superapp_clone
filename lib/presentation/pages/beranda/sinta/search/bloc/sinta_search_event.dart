part of 'sinta_search_bloc.dart';

abstract class SintaSearchEvent extends Equatable {
  const SintaSearchEvent();
}

class GetAuthorsAffiliationsJournalsEvent extends SintaSearchEvent {
  final String keyword;

  GetAuthorsAffiliationsJournalsEvent({required this.keyword});

  @override
  List<Object> get props => [keyword.toString()];
}
