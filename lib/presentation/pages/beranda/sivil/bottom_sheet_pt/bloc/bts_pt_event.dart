part of 'bts_pt_bloc.dart';

abstract class BtsPtEvent extends Equatable {
  const BtsPtEvent();
}

class BtsSearchPtEvent extends BtsPtEvent {
  final String query;

  BtsSearchPtEvent({required this.query});

  @override
  List<Object> get props => [query];
}
