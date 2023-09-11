import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListProdi.dart'
    as getListProdi;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'sivil_event.dart';
part 'sivil_state.dart';

class SivilBloc extends Bloc<SivilEvent, SivilState> {
  Logger log;

  SivilBloc({required this.log}) : super(SivilInitialState()) {
    on<UpdatePTEvent>(_updatePT);
    on<UpdateProdiEvent>(_updateProdi);
    on<UpdateNoIjazahEvent>(_updateNoIjazah);
    on<ClearEvent>(_clearEvent);
  }

  void _updatePT(UpdatePTEvent event, Emitter<SivilState> emit) async {
    if (state is SivilInitialState) {
      SivilInitialState sivilInitialState = state as SivilInitialState;
      emit(SivilInitialState(pt: event.pt, noIjazah: sivilInitialState.noIjazah));
    }
  }

  void _updateProdi(UpdateProdiEvent event, Emitter<SivilState> emit) async {
    if (state is SivilInitialState) {
      SivilInitialState sivilInitialState = state as SivilInitialState;
      emit(SivilInitialState(pt: sivilInitialState.pt, prodi: event.prodi, noIjazah: sivilInitialState.noIjazah));
    }
  }

  void _updateNoIjazah(UpdateNoIjazahEvent event, Emitter<SivilState> emit) async {
    Logger().i("_updateNoIjazah: ${event.noIjazah}");
    if (state is SivilInitialState) {
      SivilInitialState sivilInitialState = state as SivilInitialState;
      emit(SivilInitialState(pt: sivilInitialState.pt, prodi: sivilInitialState.prodi, noIjazah: event.noIjazah));
    }
  }

  void _clearEvent(ClearEvent event, Emitter<SivilState> emit) {
    print("_CLEAREVENT");
    emit(SivilInitialState());
  }

}
