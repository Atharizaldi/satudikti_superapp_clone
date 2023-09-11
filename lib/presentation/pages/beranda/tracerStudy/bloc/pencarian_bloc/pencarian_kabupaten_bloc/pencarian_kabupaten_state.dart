import 'package:app/data/source/remote/model/tracer/getList/getListKabupaten.dart';
import 'package:equatable/equatable.dart';

abstract class PencarianKabupatenTracerState extends Equatable {
  const PencarianKabupatenTracerState();
}

class PencarianKabupatenTracerLoadingState extends PencarianKabupatenTracerState {
  @override
  List<Object> get props => [];
}

class PencarianKabupatenTracerErrorState extends PencarianKabupatenTracerState {
  @override
  List<Object> get props => [];
}

class PencarianKabupatenTracerNoInternetState extends PencarianKabupatenTracerState {
  @override
  List<Object> get props => [];
}

class PencarianKabupatenTracerLoadedState extends PencarianKabupatenTracerState {
  final List<Kabupaten> listKabupaten;
  final Map<String, String> hasilKabupaten;

  PencarianKabupatenTracerLoadedState({required this.listKabupaten, required this.hasilKabupaten});

  @override
  List<Object> get props => [listKabupaten];
}