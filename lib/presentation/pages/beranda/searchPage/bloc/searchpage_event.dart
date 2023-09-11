part of 'searchpage_bloc.dart';

abstract class SearchpageEvent extends Equatable {
  const SearchpageEvent();

  @override
  List<Object> get props => [];
}

class GetFAQSearchEvent extends SearchpageEvent {
  final String keyword;

  GetFAQSearchEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class GetNewsSearchEvent extends SearchpageEvent {
  final String keyword;

  GetNewsSearchEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class GetPengumumanSearchEvent extends SearchpageEvent {
  final String keyword;

  GetPengumumanSearchEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class GetBerandaSearchEvent extends SearchpageEvent {
  final String keyword;

  GetBerandaSearchEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
