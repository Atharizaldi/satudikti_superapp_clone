part of 'garuda_searching_journal_bloc.dart';

abstract class GarudaSearchingJournalState extends Equatable {
  const GarudaSearchingJournalState();

  @override
  List<Object> get props => [];
}

class GarudaSearchingJournalInitial extends GarudaSearchingJournalState {}

// ignore: must_be_immutable
class GarudaSearchingJournalLoaded extends GarudaSearchingJournalState {
  final Garuda dataGaruda;
  final List<JournalGaruda> journalGaruda;
  final int newPage;
  bool hasReachedMax;

  GarudaSearchingJournalLoaded(
      {required this.dataGaruda,
      required this.journalGaruda,
      required this.newPage,
      required this.hasReachedMax});
  @override
  List<Object> get props => [dataGaruda, journalGaruda, newPage, hasReachedMax];
}

class GarudaSearchingJournalNotFound extends GarudaSearchingJournalState {}

class GarudaSearchingJournalNoInternet extends GarudaSearchingJournalState {}

class GarudaSearchingJournalLoading extends GarudaSearchingJournalState {}
