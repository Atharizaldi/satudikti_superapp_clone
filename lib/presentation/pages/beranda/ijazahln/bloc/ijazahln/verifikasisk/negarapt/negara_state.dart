part of 'negara_bloc.dart';

abstract class NegaraState extends Equatable {
  const NegaraState();

  @override
  List<Object> get props => [];
}

class NegaraLoading extends NegaraState {}

class NegaraInitialState extends NegaraState {
  final PerguruanTinggi? pt;
  final String? kodeNegara;
  final String? namaNegara;

  NegaraInitialState({this.pt, this.kodeNegara, this.namaNegara});
  @override
  List<Object> get props => [pt ?? '', kodeNegara ?? ''];
}

class NegaraFailed extends NegaraState {
  final bool onSearch;

  NegaraFailed({required this.onSearch});
  @override
  List<Object> get props => [onSearch];
}

class PTFailed extends NegaraState {
  final bool onSearch;

  PTFailed({required this.onSearch});
  @override
  List<Object> get props => [onSearch];
}
