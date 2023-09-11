part of 'berita_bloc.dart';

abstract class BeritaState extends Equatable {
  const BeritaState();
}

class BeritaLoadingState extends BeritaState {
  @override
  List<Object> get props => [];
}

class BeritaErrorState extends BeritaState {
  @override
  List<Object> get props => [];
}

class BeritaNoInternetState extends BeritaState {
  @override
  List<Object> get props => [];
}

class BeritaLoadedState extends BeritaState {
  final int page;
  final List<Data> newsList;
  final bool hasReachedMax;

  BeritaLoadedState({required this.page, required this.newsList, required this.hasReachedMax});

  @override
  List<Object> get props => [page, newsList, hasReachedMax];
}