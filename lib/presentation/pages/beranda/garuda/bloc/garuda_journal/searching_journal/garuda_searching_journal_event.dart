part of 'garuda_searching_journal_bloc.dart';

abstract class GarudaSearchingJournalEvent extends Equatable {
  const GarudaSearchingJournalEvent();

  @override
  List<Object> get props => [];
}

class GarudaSearchingEvent extends GarudaSearchingJournalEvent {
  final String? keyword;

  GarudaSearchingEvent({this.keyword});
  @override
  List<Object> get props => [keyword.toString()];
}

class GarudaSearchingBySubjectEvent extends GarudaSearchingJournalEvent {
  final String? id, keyword;

  GarudaSearchingBySubjectEvent({this.id, this.keyword});
  @override
  List<Object> get props => [id.toString(), keyword.toString()];
}
