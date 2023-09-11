part of 'garuda_bloc.dart';

abstract class GarudaState extends Equatable {
  const GarudaState();

  @override
  List<Object> get props => [];
}

class GarudaInitialState extends GarudaState {}

class GarudaLoadingState extends GarudaState {}

class GarudaLoadedState extends GarudaState {
  final Garuda dataGaruda;
  final List<JournalGaruda> journalGaruda;
  final int newPage;
  final bool hasReachedMax;
  GarudaLoadedState(
      {required this.dataGaruda,
      required this.journalGaruda,
      required this.newPage,
      required this.hasReachedMax});

  @override
  List<Object> get props => [dataGaruda, journalGaruda, newPage, hasReachedMax];
}

class GarudaNoInternetState extends GarudaState {}

class GarudaServerBermasalahState extends GarudaState {}

class GarudaTidakAdaDataState extends GarudaState {}
