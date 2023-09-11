part of 'pt_bloc.dart';

abstract class PtState extends Equatable {
  const PtState();
}

class PtNoInternetState extends PtState {
  @override
  List<Object> get props => [];
}

class PtLoadingState extends PtState {
  @override
  List<Object> get props => [];
}

class PtNotFoundState extends PtState {
  @override
  List<Object> get props => [];
}

class PtLoadedState extends PtState {
  final SearchTrackingUsulan getListPT;
  final List<String> listPtName;

  PtLoadedState({required this.getListPT, required this.listPtName});

  @override
  List<Object> get props => [getListPT, listPtName];
}
