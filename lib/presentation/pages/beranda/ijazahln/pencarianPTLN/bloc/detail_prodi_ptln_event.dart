part of 'detail_prodi_ptln_bloc.dart';

abstract class DetailProdiPtlnEvent extends Equatable {
  const DetailProdiPtlnEvent();
}

class GetDetailProdiPtlnEvent extends DetailProdiPtlnEvent {
  final String idPt;

  GetDetailProdiPtlnEvent({required this.idPt});

  @override
  List<Object> get props => [idPt];
}
