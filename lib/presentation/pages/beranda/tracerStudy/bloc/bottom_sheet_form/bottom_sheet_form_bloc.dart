import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_sheet_form_event.dart';
part 'bottom_sheet_form_state.dart';

class BottomSheetFormTracerBloc
    extends Bloc<BottomSheetFormTracerEvent, BottomSheetFormTracerState> {
  BottomSheetFormTracerBloc() : super(BottomSheetFormInitialState()) {
    on<UpdateProvinsiEvent>(_updateProvinsi);
    on<UpdateKabupatenEvent>(_updateKabupaten);
    on<UpdatePTEvent>(_updatePT);
    on<UpdateProdiEvent>(_updateProdi);
    on<ClearTracerEvent>(_clearTracerEvent);
  }

  void _updateProvinsi(
      UpdateProvinsiEvent event, Emitter<BottomSheetFormTracerState> emit) async {
    if (state is BottomSheetFormInitialState) {
      emit(BottomSheetFormInitialState(
        namaProvinsi: event.namaProvinsi,
        kodeProvinsi: event.kodeProvinsi,
      ));
    }
  }

  void _updateKabupaten(
      UpdateKabupatenEvent event, Emitter<BottomSheetFormTracerState> emit) async {
    if (state is BottomSheetFormInitialState) {
      emit(BottomSheetFormInitialState(
        namaKabupaten: event.namaKabupaten,
        kodeKabupaten: event.kodeKabupaten,
      ));
    }
  }

  void _updatePT(
      UpdatePTEvent event, Emitter<BottomSheetFormTracerState> emit) async {
    if (state is BottomSheetFormInitialState) {
      emit(BottomSheetFormInitialState(
        namaKabupaten: event.namaPT,
        kodeKabupaten: event.kodePT,
      ));
    }
  }

  void _updateProdi(
      UpdateProdiEvent event, Emitter<BottomSheetFormTracerState> emit) async {
    if (state is BottomSheetFormInitialState) {
      emit(BottomSheetFormInitialState(
        namaKabupaten: event.namaProdi,
        kodeKabupaten: event.kodeProdi,
      ));
    }
  }

  void _clearTracerEvent(
      ClearTracerEvent event, Emitter<BottomSheetFormTracerState> emit) {
    print("_CLEAREVENT");
    emit(BottomSheetFormInitialState());
  }
}
