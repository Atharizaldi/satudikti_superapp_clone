part of 'detail_pencarian_prodi_bloc.dart';

abstract class DetailPencarianProdiEvent extends Equatable {
  const DetailPencarianProdiEvent();

  @override
  List<Object> get props => [];
}

class LoadPencarianProdiEvent extends DetailPencarianProdiEvent {
  final String kodePT, kodeProdi;
  final bool fromPT;
  const LoadPencarianProdiEvent(
      {required this.kodePT, required this.kodeProdi, required this.fromPT});
  @override
  List<Object> get props => [kodePT, kodeProdi, fromPT];
}

class LoadPencarianProdiRegEvent extends DetailPencarianProdiEvent {
  final String idReg;
  final bool fromPT;
  const LoadPencarianProdiRegEvent({required this.idReg, required this.fromPT});
  @override
  List<Object> get props => [idReg];
}
