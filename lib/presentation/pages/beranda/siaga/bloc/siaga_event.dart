part of 'siaga_bloc.dart';

abstract class SiagaEvent extends Equatable {
  const SiagaEvent();

  @override
  List<Object> get props => [];
}

class UpdateSiagaEvent extends SiagaEvent {
  final SearchTracking pt;

  UpdateSiagaEvent({required this.pt});

  @override
  List<Object> get props => [pt];
}
