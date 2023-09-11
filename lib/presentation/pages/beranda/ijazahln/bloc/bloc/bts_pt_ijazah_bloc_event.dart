part of 'bts_pt_ijazah_bloc.dart';

abstract class BtsPtIjazahBlocEvent extends Equatable {
  const BtsPtIjazahBlocEvent();

  @override
  List<Object> get props => [];
}

class BtsSearchPtIjazahEvent extends BtsPtIjazahBlocEvent {
  final String query;
  final String idNegara;

  BtsSearchPtIjazahEvent({required this.query, required this.idNegara});

  @override
  List<Object> get props => [query, idNegara];
}
