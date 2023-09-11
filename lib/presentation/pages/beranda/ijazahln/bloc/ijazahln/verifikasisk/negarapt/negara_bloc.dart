import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ptIjazahLNList.dart';
import 'package:app/domain/usecases/ijazahln/getNegara.dart';
import 'package:app/domain/usecases/ijazahln/getPT.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'negara_event.dart';
part 'negara_state.dart';

class NegaraBloc extends Bloc<NegaraEvent, NegaraState> {
  GetNegara getNegara;
  GetPT getPT;
  NegaraBloc({required this.getNegara, required this.getPT})
      : super(NegaraInitialState()) {
    on<UpdateNegaraEvent>(_updateNegara);
    on<UpdatePTIjazahEvent>(_updatePTIjazah);
  }
  void _updateNegara(UpdateNegaraEvent event, Emitter<NegaraState> emit) async {
    emit(NegaraInitialState(
        kodeNegara: event.kodeNegara.toString(), namaNegara: event.namaNegara));
  }

  void _updatePTIjazah(
      UpdatePTIjazahEvent event, Emitter<NegaraState> emit) async {
    if (state is NegaraInitialState) {
      NegaraInitialState sivilInitialState = state as NegaraInitialState;
      emit(NegaraInitialState(
          pt: event.pt, kodeNegara: sivilInitialState.kodeNegara));
    }
  }
}
