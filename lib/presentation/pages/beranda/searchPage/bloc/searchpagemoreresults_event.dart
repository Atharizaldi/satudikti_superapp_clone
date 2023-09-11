part of 'searchpagemoreresults_bloc.dart';

abstract class SearchpagemoreresultsEvent extends Equatable {
  const SearchpagemoreresultsEvent();

  @override
  List<Object> get props => [];
}

class GetMorePengumumanResultsEvent extends SearchpagemoreresultsEvent {
  final String keyword;
  const GetMorePengumumanResultsEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class GetMoreNewsResultsEvent extends SearchpagemoreresultsEvent {
  final String keyword;
  const GetMoreNewsResultsEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
