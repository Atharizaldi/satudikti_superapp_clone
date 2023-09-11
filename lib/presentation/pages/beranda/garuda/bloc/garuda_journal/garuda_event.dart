part of 'garuda_bloc.dart';

abstract class GarudaEvent extends Equatable {
  const GarudaEvent();

  @override
  List<Object> get props => [];
}

class SearchGarudaJournalEvent extends GarudaEvent {}

class SearchGarudaJournalRefreshEvent extends GarudaEvent {}
