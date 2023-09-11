part of 'searchpagemoreresults_bloc.dart';

abstract class SearchpagemoreresultsState extends Equatable {
  const SearchpagemoreresultsState();

  @override
  List<Object> get props => [];
}

class SearchpagemoreresultsLoadingState extends SearchpagemoreresultsState {}

class SearchpagemoreresultsPengumumanLoadedState
    extends SearchpagemoreresultsState {
  final int page;
  final List<p.Data> pengumumanList;
  final bool hasReachedMax;

  SearchpagemoreresultsPengumumanLoadedState({
    required this.page,
    required this.pengumumanList,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [page, pengumumanList, hasReachedMax];
}

class SearchpagemoreresultsBeritaLoadedState
    extends SearchpagemoreresultsState {
  final int page;
  final List<n.Data> newsList;
  final bool hasReachedMax;

  SearchpagemoreresultsBeritaLoadedState({
    required this.page,
    required this.newsList,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [page, newsList, hasReachedMax];
}

class SearchpagemoreresultsNoInternetState extends SearchpagemoreresultsState {}
