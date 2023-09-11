part of 'negara_bloc.dart';

abstract class NegaraEvent extends Equatable {
  const NegaraEvent();

  @override
  List<Object> get props => [];
}

class UpdateNegaraEvent extends NegaraEvent {
  final String? kodeNegara;
  final String? namaNegara;

  UpdateNegaraEvent({required this.kodeNegara, this.namaNegara});

  @override
  List<Object> get props => [kodeNegara.toString(), namaNegara.toString()];
}

class UpdatePTIjazahEvent extends NegaraEvent {
  final PerguruanTinggi pt;

  UpdatePTIjazahEvent({required this.pt});

  @override
  List<Object> get props => [pt];
}
