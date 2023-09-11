part of 'ijazahbyno_bloc.dart';

abstract class IjazahbynoEvent extends Equatable {
  const IjazahbynoEvent();

  @override
  List<Object> get props => [];
}

class FetchIjazahByNo extends IjazahbynoEvent {
  final String query;

  FetchIjazahByNo(this.query);
  @override
  List<Object> get props => [query];
}

class FetchIjazahByNoFailed extends IjazahbynoEvent {
  @override
  List<Object> get props => [];
}
