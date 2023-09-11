part of 'bottom_sheet_form_bloc.dart';

abstract class BottomSheetFormTracerState extends Equatable {
  const BottomSheetFormTracerState();

  @override
  List<Object> get props => [];
}

class BottomSheetFormInitialState extends BottomSheetFormTracerState {
  final String? namaProvinsi;
  final String? kodeProvinsi;
  final String? namaKabupaten;
  final String? kodeKabupaten;
  final String? namaPT;
  final String? kodePT;
  final String? namaProdi;
  final String? kodeProdi;

  BottomSheetFormInitialState(
      {
        this.namaProvinsi, 
        this.kodeProvinsi,
        this.namaKabupaten, 
        this.kodeKabupaten,
        this.namaPT, 
        this.kodePT,
        this.namaProdi, 
        this.kodeProdi,
      });

  @override
  List<Object> get props => [
        namaProvinsi  ?? "",
        kodeProvinsi  ?? "",
        namaKabupaten ?? "",
        kodeKabupaten ?? "",
        namaPT        ?? "",
        kodePT        ?? "",
        namaProdi     ?? "",
        kodeProdi     ?? "",
      ];
}
