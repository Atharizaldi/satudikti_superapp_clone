part of 'verifikasisk_bloc.dart';

abstract class VerifikasiskEvent extends Equatable {
  const VerifikasiskEvent();

  @override
  List<Object> get props => [];
}

class FetchVerifikasiSk extends VerifikasiskEvent {
  final String idNegara;
  final String idPt;
  final String nomorSK;

  FetchVerifikasiSk(this.idNegara, this.idPt, this.nomorSK);
  @override
  List<Object> get props => [];
}

class FetchVerifikasiFailed extends VerifikasiskEvent {}
