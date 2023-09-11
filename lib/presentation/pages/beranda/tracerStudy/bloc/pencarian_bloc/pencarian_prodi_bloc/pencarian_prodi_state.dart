import 'package:app/data/source/remote/model/tracer/getList/getListProdi.dart';
import 'package:equatable/equatable.dart';

abstract class PencarianProdiTracerState extends Equatable {
  const PencarianProdiTracerState();
}

class PencarianProdiTracerLoadingState extends PencarianProdiTracerState {
  @override
  List<Object> get props => [];
}

class PencarianProdiTracerErrorState extends PencarianProdiTracerState {
  @override
  List<Object> get props => [];
}

class PencarianProdiTracerNoInternetState extends PencarianProdiTracerState {
  @override
  List<Object> get props => [];
}

class PencarianProdiTracerLoadedState extends PencarianProdiTracerState {
  final List<DataProdiTracer> listProdi;

  PencarianProdiTracerLoadedState({required this.listProdi});

  @override
  List<Object> get props => [listProdi];
}