part of 'bts_pt_bloc.dart';

abstract class BtsPtState extends Equatable {
  const BtsPtState();
}

class BtsPtNoInternetState extends BtsPtState {
  @override
  List<Object> get props => [];
}

class BtsPtLoadingState extends BtsPtState {
  @override
  List<Object> get props => [];
}

class BtsPtNotFoundState extends BtsPtState {
  @override
  List<Object> get props => [];
}

class BtsPtLoadedState extends BtsPtState {
  final GetListPT getListPT;
  final List<String> listPtName;

  BtsPtLoadedState({required this.getListPT, required this.listPtName});

  @override
  List<Object> get props => [getListPT, listPtName];
}
