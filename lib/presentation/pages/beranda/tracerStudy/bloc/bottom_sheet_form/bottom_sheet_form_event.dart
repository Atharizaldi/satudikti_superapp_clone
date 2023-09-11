part of 'bottom_sheet_form_bloc.dart';

abstract class BottomSheetFormTracerEvent extends Equatable {
  const BottomSheetFormTracerEvent();

  @override
  List<Object> get props => [];
}

class UpdateProvinsiEvent extends BottomSheetFormTracerEvent {
  final String namaProvinsi;
  final String kodeProvinsi;

  UpdateProvinsiEvent({
    required this.namaProvinsi,
    required this.kodeProvinsi,
  });

  @override
  List<Object> get props => [namaProvinsi, kodeProvinsi];
}

class UpdateKabupatenEvent extends BottomSheetFormTracerEvent {
  final String namaKabupaten;
  final String kodeKabupaten;

  UpdateKabupatenEvent({
    required this.namaKabupaten,
    required this.kodeKabupaten,
  });

  @override
  List<Object> get props => [namaKabupaten, kodeKabupaten];
}

class UpdatePTEvent extends BottomSheetFormTracerEvent {
  final String namaPT;
  final String kodePT;

  UpdatePTEvent({
    required this.namaPT,
    required this.kodePT,
  });

  @override
  List<Object> get props => [namaPT, kodePT];
}

class UpdateProdiEvent extends BottomSheetFormTracerEvent {
  final String namaProdi;
  final String kodeProdi;

  UpdateProdiEvent({
    required this.namaProdi,
    required this.kodeProdi,
  });

  @override
  List<Object> get props => [namaProdi, kodeProdi];
}

class ClearTracerEvent extends BottomSheetFormTracerEvent {}
