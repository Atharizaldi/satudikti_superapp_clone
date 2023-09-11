part of 'verifikasisk_bloc.dart';

abstract class VerifikasiskState extends Equatable {
  const VerifikasiskState();

  @override
  List<Object> get props => [];
}

class VerifikasiskLoading extends VerifikasiskState {}

class VerifikasiskLoaded extends VerifikasiskState {
  final VerifikasiSK listVerif;

  VerifikasiskLoaded({required this.listVerif});
  @override
  List<Object> get props => [];
}

class VerifikasiSkFailed extends VerifikasiskState {
  @override
  List<Object> get props => [];
}
