part of 'garuda_umum_search_bloc.dart';

abstract class GarudaUmumSearchState extends Equatable {
  const GarudaUmumSearchState();

  @override
  List<Object> get props => [];
}

class GarudaUmumSearchInitial extends GarudaUmumSearchState {}

class GarudaUmumSearchLoading extends GarudaUmumSearchState {}

class GarudaUmumSearchFailed extends GarudaUmumSearchState {}

class GarudaUmumSearchNoInternet extends GarudaUmumSearchState {}

class GarudaUmumSearchLoaded extends GarudaUmumSearchState {
  final GarudaPaper? garudaPaperObject;
  final List<ListPaperGaruda>? garudaPaper;
  final Garuda? dataGaruda;
  final List<JournalGaruda>? journalGaruda;

  GarudaUmumSearchLoaded(
      {required this.garudaPaperObject,
      required this.garudaPaper,
      required this.dataGaruda,
      required this.journalGaruda});
  @override
  List<Object> get props =>
      [garudaPaperObject!, garudaPaper!, dataGaruda!, journalGaruda!];
}
