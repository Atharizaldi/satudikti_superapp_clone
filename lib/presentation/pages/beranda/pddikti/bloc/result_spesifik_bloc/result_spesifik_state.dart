part of 'result_spesifik_bloc.dart';

abstract class ResultSpesifikState extends Equatable {
  const ResultSpesifikState();

  @override
  List<Object> get props => [];
}

class ResultSpesifikLoadingState extends ResultSpesifikState {}

class ResultSpesifikNoInternetState extends ResultSpesifikState {}

class ResultSpesifikNotFoundState extends ResultSpesifikState {}

class ResultSpesifikLoadedState extends ResultSpesifikState {}

class ResultMahasiswaLoadedState extends ResultSpesifikState {}

class ResultDosenLoadedState extends ResultSpesifikState {}

class ResultPTLoadedState extends ResultSpesifikState {}

class ResultProdiLoadedState extends ResultSpesifikState {}
