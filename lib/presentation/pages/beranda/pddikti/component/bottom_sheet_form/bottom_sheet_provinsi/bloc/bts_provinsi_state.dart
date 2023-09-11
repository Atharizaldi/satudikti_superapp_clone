part of 'bts_provinsi_bloc.dart';

abstract class BtsProvinsiState extends Equatable {
  const BtsProvinsiState();

  @override
  List<Object> get props => [];
}

class BtsProvinsiInitial extends BtsProvinsiState {}

class BtsProvinsiNoInternetState extends BtsProvinsiState {
  @override
  List<Object> get props => [];
}

class BtsProvinsiLoadingState extends BtsProvinsiState {
  @override
  List<Object> get props => [];
}

class BtsProvinsiNotFoundState extends BtsProvinsiState {
  @override
  List<Object> get props => [];
}

class BtsProvinsiLoadedState extends BtsProvinsiState {
  final List<String> matchesProvinsi;

  BtsProvinsiLoadedState({required this.matchesProvinsi});

  @override
  List<Object> get props => [matchesProvinsi];
}
