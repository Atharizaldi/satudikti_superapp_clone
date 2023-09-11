part of 'bts_negara_bloc.dart';

abstract class BtsNegaraBlocEvent extends Equatable {
  const BtsNegaraBlocEvent();

  @override
  List<Object> get props => [];
}

class BtsInitialNegaraEvent extends BtsNegaraBlocEvent {
  BtsInitialNegaraEvent();
  @override
  List<Object> get props => [];
}

class BtsSearchNegaraEvent extends BtsNegaraBlocEvent {
  final String query;

  BtsSearchNegaraEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class SelectedNegaraEvent extends BtsNegaraBlocEvent {
  final String namaNegara;

  SelectedNegaraEvent({required this.namaNegara});

  @override
  List<Object> get props => [namaNegara];
}
