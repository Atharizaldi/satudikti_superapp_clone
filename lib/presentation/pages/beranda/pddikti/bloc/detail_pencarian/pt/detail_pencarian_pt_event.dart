part of 'detail_pencarian_pt_bloc.dart';

abstract class DetailPencarianPtEvent extends Equatable {
  const DetailPencarianPtEvent();

  @override
  List<Object> get props => [];
}

class LoadPencarianEvent extends DetailPencarianPtEvent {
  final String kodePT;
  final bool fromSpecific;
  const LoadPencarianEvent({required this.kodePT, required this.fromSpecific});

  @override
  List<Object> get props => [];
}

class IDPTPDDIKTIEvent extends DetailPencarianPtEvent {
  final String id;

  const IDPTPDDIKTIEvent({required this.id});

  @override
  List<Object> get props => [id];
}
