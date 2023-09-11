import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/negaraIjazahLNList.dart';
import 'package:app/domain/usecases/ijazahln/getNegara.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bts_negara_bloc_event.dart';
part 'bts_negara_bloc_state.dart';

class BtsNegaraBlocBloc extends Bloc<BtsNegaraBlocEvent, BtsNegaraBlocState> {
  GetNegara getNegara;

  BtsNegaraBlocBloc({required this.getNegara})
      : super(BtsNegaraNotFoundState()) {
    on<BtsInitialNegaraEvent>(_initialNegara);
    on<BtsSearchNegaraEvent>(_searchNegara);
  }

  void _initialNegara(
      BtsInitialNegaraEvent event, Emitter<BtsNegaraBlocState> emit) async {
    emit(BtsNegaraLoadingState());
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      final result = await getNegara.execute('', '');
      await result.fold(
        (failure) async {
          emit(BtsNegaraNotFoundState());
        },
        (getListNegara) async {
          emit(BtsNegaraLoadedState(
              listNegara: getListNegara.data.negara,
              listNegaraTemp: getListNegara.data.negara));
        },
      );
    } else {
      emit(BtsNegaraNoInternetState());
    }
  }

  void _searchNegara(
      BtsSearchNegaraEvent event, Emitter<BtsNegaraBlocState> emit) async {
    emit(BtsNegaraLoadingState());
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      final result = await getNegara.execute('', event.query);
      await result.fold(
        (failure) async {
          emit(BtsNegaraNotFoundState());
        },
        (getListNegara) async {
          List<Negara> filteredListNegara = getListNegara.data.negara
              .where((e) => e.negaraName
                  .toLowerCase()
                  .contains(event.query.toLowerCase()))
              .toList();
          if (filteredListNegara.isEmpty) {
            emit(BtsNegaraNotFoundState());
          } else {
            emit(BtsNegaraLoadedState(
                listNegara: getListNegara.data.negara,
                listNegaraTemp: filteredListNegara));
          }
        },
      );
    } else {
      emit(BtsNegaraNoInternetState());
    }
  }
}
