part of 'bottom_sheet_form_bloc.dart';

abstract class BottomSheetFormEvent extends Equatable {
  const BottomSheetFormEvent();

  @override
  List<Object> get props => [];
}

class UpdatePTEvent extends BottomSheetFormEvent {
  final PerguruanTinggi pt;

  UpdatePTEvent({required this.pt});

  @override
  List<Object> get props => [pt];
}

class UpdateProdiEvent extends BottomSheetFormEvent {
  final getListProdi.Prodi prodi;

  UpdateProdiEvent({required this.prodi});

  @override
  List<Object> get props => [prodi];
}

class UpdateProvinsiEvent extends BottomSheetFormEvent {
  final String namaProvinsi;
  final String kodeProvinsi;

  UpdateProvinsiEvent({
    required this.namaProvinsi,
    required this.kodeProvinsi,
  });

  @override
  List<Object> get props => [namaProvinsi, kodeProvinsi];
}

class ClearProvinsiEvent extends BottomSheetFormEvent {}
