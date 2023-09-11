part of 'searchpage_bloc.dart';

abstract class SearchpageState extends Equatable {
  const SearchpageState();

  @override
  List<Object> get props => [];
}

class SearchpageInitialState extends SearchpageState {}

class SearchpageNoInternetState extends SearchpageState {}

class SearchpageNotFoundState extends SearchpageState {}

class SearchpageServerErrorState extends SearchpageState {}

class SearchpageFAQLoadedState extends SearchpageState {
  final FAQList listFAQ;

  SearchpageFAQLoadedState({
    required this.listFAQ,
  });

  @override
  List<Object> get props => [listFAQ];
}

class SearchpageBeritaLoadedState extends SearchpageState {
  final NewsList newsList;

  SearchpageBeritaLoadedState({
    required this.newsList,
  });

  @override
  List<Object> get props => [newsList];
}

class SearchpagePengumumanLoadedState extends SearchpageState {
  final bool flagPengumuman;
  final PengumumanList pengumumanList;

  SearchpagePengumumanLoadedState({
    required this.pengumumanList,
    this.flagPengumuman = false,
  });

  @override
  List<Object> get props => [
        flagPengumuman,
        pengumumanList,
      ];
}

class SearchpageBerandaLoadedState extends SearchpageState {
  final bool flagBerita, flagPengumuman, flagLayanan;
  final NewsList? newsList;
  final PengumumanList? pengumumanList;
  final AutoGenerate? listModul;

  SearchpageBerandaLoadedState({
    required this.newsList,
    required this.pengumumanList,
    required this.listModul,
    required this.flagBerita,
    required this.flagPengumuman,
    required this.flagLayanan,
  });

  @override
  List<Object> get props => [
        flagPengumuman,
        pengumumanList!,
        newsList!,
        listModul!,
      ];
}
