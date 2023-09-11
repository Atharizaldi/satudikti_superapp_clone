part of 'bts_pt_ijazah_bloc.dart';

abstract class BtsPtIjazahBlocState extends Equatable {
  const BtsPtIjazahBlocState();

  @override
  List<Object> get props => [];
}

class BtsPtIjazahNoInternetState extends BtsPtIjazahBlocState {
  @override
  List<Object> get props => [];
}

class BtsPtIjazahLoadingState extends BtsPtIjazahBlocState {
  @override
  List<Object> get props => [];
}

class BtsPtIjazahNotFoundState extends BtsPtIjazahBlocState {
  @override
  List<Object> get props => [];
}

class BtsPtIjazahLoadedState extends BtsPtIjazahBlocState {
  final PtIjazahLNList getListPT;
  final List<String> listPtName;

  BtsPtIjazahLoadedState({required this.getListPT, required this.listPtName});

  @override
  List<Object> get props => [getListPT, listPtName];
}
