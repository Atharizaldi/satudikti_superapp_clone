part of 'bts_negara_bloc.dart';

abstract class BtsNegaraBlocState extends Equatable {
  const BtsNegaraBlocState();

  @override
  List<Object> get props => [];
}

class BtsNegaraNoInternetState extends BtsNegaraBlocState {
  @override
  List<Object> get props => [];
}

class BtsNegaraLoadingState extends BtsNegaraBlocState {
  @override
  List<Object> get props => [];
}

class BtsNegaraNotFoundState extends BtsNegaraBlocState {
  @override
  List<Object> get props => [];
}

class BtsNegaraLoadedState extends BtsNegaraBlocState {
  final List<Negara> listNegara;
  final List<Negara> listNegaraTemp;

  BtsNegaraLoadedState({
    required this.listNegara,
    required this.listNegaraTemp,
  });

  @override
  List<Object> get props => [listNegara, listNegaraTemp];
}
