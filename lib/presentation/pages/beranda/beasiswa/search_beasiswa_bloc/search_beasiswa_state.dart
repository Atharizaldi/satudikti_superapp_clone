part of 'search_beasiswa_bloc.dart';

abstract class SearchBeasiswaState extends Equatable {
  const SearchBeasiswaState();

  @override
  List<Object> get props => [];
}

class SearchBeasiswaLoadingState extends SearchBeasiswaState {}

class SearchBeasiswaInitState extends SearchBeasiswaState {}

class SearchBeasiswaNoInternetState extends SearchBeasiswaState {}

class SearchBeasiswaServerErrorState extends SearchBeasiswaState {}

class InitSearchBeasiswaLoadedState extends SearchBeasiswaState {
  final Beasiswa beasiswa;
  List<ListBeasiswa> listBeasiswa;

  InitSearchBeasiswaLoadedState(
      {required this.beasiswa, required this.listBeasiswa});
  @override
  List<Object> get props => [beasiswa, listBeasiswa];
}

class SearchBeasiswaLoadedState extends SearchBeasiswaState {
  final Beasiswa beasiswa;
  final bool hasReached;
  final int page;
  final List<ListBeasiswa> listBeasiswa;
  final String? searchKeyword;

  SearchBeasiswaLoadedState(
      {required this.beasiswa,
      required this.hasReached,
      required this.page,
      required this.listBeasiswa,
      this.searchKeyword});
  @override
  List<Object> get props =>
      [beasiswa, hasReached, page, listBeasiswa, searchKeyword!];
}
