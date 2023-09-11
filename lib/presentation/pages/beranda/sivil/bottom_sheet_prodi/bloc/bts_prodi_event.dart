part of 'bts_prodi_bloc.dart';

abstract class BtsProdiEvent extends Equatable {
  const BtsProdiEvent();
}

class BtsSearchProdiEvent extends BtsProdiEvent {
  final String idPt;
  final String query;

  BtsSearchProdiEvent({required this.idPt, required this.query});

  @override
  List<Object> get props => [idPt, query];
}

