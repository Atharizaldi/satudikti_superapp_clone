import 'package:app/data/source/remote/model/pddikti/prodi/getListProdi.dart'
    as getListProdi;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';

part 'bottom_sheet_form_event.dart';
part 'bottom_sheet_form_state.dart';

class BottomSheetFormBloc
    extends Bloc<BottomSheetFormEvent, BottomSheetFormState> {
  BottomSheetFormBloc() : super(BottomSheetFormInitialState()) {
    on<UpdatePTEvent>(_updatePT);
    on<UpdateProdiEvent>(_updateProdi);
    on<UpdateProvinsiEvent>(_updateProvinsi);
    on<ClearProvinsiEvent>(_clearProvinsiEvent);
  }

  void _updatePT(
      UpdatePTEvent event, Emitter<BottomSheetFormState> emit) async {
    emit(BottomSheetFormInitialState(pt: event.pt));
  }

  void _updateProdi(
      UpdateProdiEvent event, Emitter<BottomSheetFormState> emit) async {
    if (state is BottomSheetFormInitialState) {
      BottomSheetFormInitialState bottomSheetFormInitialState =
          state as BottomSheetFormInitialState;
      emit(BottomSheetFormInitialState(
          pt: bottomSheetFormInitialState.pt, prodi: event.prodi));
    }
  }

  void _updateProvinsi(
      UpdateProvinsiEvent event, Emitter<BottomSheetFormState> emit) async {
    if (state is BottomSheetFormInitialState) {
      emit(BottomSheetFormInitialState(
        namaProvinsi: event.namaProvinsi,
        kodeProvinsi: event.kodeProvinsi,
      ));
    }
  }

  void _clearProvinsiEvent(
      ClearProvinsiEvent event, Emitter<BottomSheetFormState> emit) {
    print("_CLEARProvinsiEVENT");
    emit(BottomSheetFormInitialState());
  }
}
