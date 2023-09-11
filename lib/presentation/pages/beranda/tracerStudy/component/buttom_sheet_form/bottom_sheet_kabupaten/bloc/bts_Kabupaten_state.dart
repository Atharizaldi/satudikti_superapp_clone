part of 'bts_Kabupaten_bloc.dart';

abstract class BtsKabupatenState extends Equatable {
  const BtsKabupatenState();

  @override
  List<Object> get props => [];
}

class BtsKabupatenInitial extends BtsKabupatenState {}

class BtsKabupatenNoInternetState extends BtsKabupatenState {
  @override
  List<Object> get props => [];
}

class BtsKabupatenLoadingState extends BtsKabupatenState {
  @override
  List<Object> get props => [];
}

class BtsKabupatenNotFoundState extends BtsKabupatenState {
  @override
  List<Object> get props => [];
}

class BtsKabupatenLoadedState extends BtsKabupatenState {
  final List<String> matchesKabupaten;

  BtsKabupatenLoadedState({required this.matchesKabupaten});

  @override
  List<Object> get props => [matchesKabupaten];
}
