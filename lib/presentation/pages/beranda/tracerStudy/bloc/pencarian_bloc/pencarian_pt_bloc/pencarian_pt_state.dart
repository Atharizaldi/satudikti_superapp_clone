import 'package:app/data/source/remote/model/tracer/getList/getListPT.dart';
import 'package:equatable/equatable.dart';

abstract class PencarianPtTracerState extends Equatable {
  const PencarianPtTracerState();
}

class PencarianPtTracerLoadingState extends PencarianPtTracerState {
  @override
  List<Object> get props => [];
}

class PencarianPtTracerErrorState extends PencarianPtTracerState {
  @override
  List<Object> get props => [];
}

class PencarianPtTracerNoInternetState extends PencarianPtTracerState {
  @override
  List<Object> get props => [];
}

class PencarianPtTracerLoadedState extends PencarianPtTracerState {
  final List<DataPtTracer> listPt;

  PencarianPtTracerLoadedState({required this.listPt});

  @override
  List<Object> get props => [listPt];
}