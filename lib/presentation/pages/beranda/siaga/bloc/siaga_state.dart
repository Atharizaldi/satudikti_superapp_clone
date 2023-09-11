part of 'siaga_bloc.dart';

abstract class SiagaState extends Equatable {
  const SiagaState();

  @override
  List<Object> get props => [];
}

class SiagaInitialState extends SiagaState {
  final SearchTracking? pt;

  SiagaInitialState({
    this.pt,
  });

  @override
  List<Object> get props => [pt ?? ''];
}

class SiagaErrorState extends SiagaState {}
