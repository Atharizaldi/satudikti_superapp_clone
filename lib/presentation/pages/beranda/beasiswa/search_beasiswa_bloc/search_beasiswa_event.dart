part of 'search_beasiswa_bloc.dart';

abstract class SearchBeasiswaEvent extends Equatable {
  const SearchBeasiswaEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchBeasiswaEvent extends SearchBeasiswaEvent {
  final String? keyword;

  FetchSearchBeasiswaEvent({this.keyword});
  @override
  List<Object> get props => [keyword.toString()];
}

class InitFetchSearchBeasiswaEvent extends SearchBeasiswaEvent {
  final String? keyword;
  final bool? closedFilter;

  InitFetchSearchBeasiswaEvent({this.closedFilter, this.keyword});
  @override
  List<Object> get props => [keyword.toString()];
}

class FetchSearchBeasiswaFilterEvent extends SearchBeasiswaEvent {
  final String? keyword;
  final int? penerima;

  FetchSearchBeasiswaFilterEvent({this.keyword, this.penerima});
  @override
  List<Object> get props => [keyword.toString(), penerima!];
}
