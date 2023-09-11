part of 'bottom_sheet_form_bloc.dart';

abstract class BottomSheetFormState extends Equatable {
  const BottomSheetFormState();

  @override
  List<Object> get props => [];
}

class BottomSheetFormInitialState extends BottomSheetFormState {
  final PerguruanTinggi? pt;
  final getListProdi.Prodi? prodi;
  final String? namaProvinsi;
  final String? kodeProvinsi;
  // final getListProdi.Prodi? prodi;

  BottomSheetFormInitialState(
      {this.pt, this.prodi, this.namaProvinsi, this.kodeProvinsi});

  @override
  List<Object> get props => [
        pt ?? '',
        prodi ?? '',
        namaProvinsi ?? "",
        kodeProvinsi ?? "",
      ];
}
