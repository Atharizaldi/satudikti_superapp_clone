part of 'bts_prodi_bloc.dart';

abstract class BtsProdiState extends Equatable {
  const BtsProdiState();
}

class BtsProdiNoInternetState extends BtsProdiState {
  @override
  List<Object> get props => [];
}

class BtsProdiLoadingState extends BtsProdiState {
  @override
  List<Object> get props => [];
}

class BtsProdiNotFoundState extends BtsProdiState {
  @override
  List<Object> get props => [];
}

class BtsProdiLoadedState extends BtsProdiState {
  final GetListProdi getListProdi;
  final List<String> listProdiJenjangDidikName;

  BtsProdiLoadedState({required this.getListProdi, required this.listProdiJenjangDidikName});

  @override
  List<Object> get props => [getListProdi, listProdiJenjangDidikName];
}