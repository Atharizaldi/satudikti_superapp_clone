import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ptIjazahLNList.dart';
import 'package:app/domain/usecases/ijazahln/getPT.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bts_pt_ijazah_bloc_event.dart';
part 'bts_pt_ijazah_bloc_state.dart';

class BtsPtIjazahBloc extends Bloc<BtsPtIjazahBlocEvent, BtsPtIjazahBlocState> {
  GetPT getPT;

  BtsPtIjazahBloc({required this.getPT}) : super(BtsPtIjazahNotFoundState()) {
    on<BtsSearchPtIjazahEvent>(_searchPTIjazah);
  }

  void _searchPTIjazah(
      BtsSearchPtIjazahEvent event, Emitter<BtsPtIjazahBlocState> emit) async {
    emit(BtsPtIjazahLoadingState());
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      final result = await getPT.execute('', event.idNegara, event.query);
      await result.fold(
        (failure) async {
          emit(BtsPtIjazahNotFoundState());
        },
        (getListPT) async {
          List<String> list =
              getListPT.data.perguruanTinggi.map((e) => e.ptName).toList();
          if (list.isEmpty) {
            emit(BtsPtIjazahNotFoundState());
          } else {
            emit(
                BtsPtIjazahLoadedState(getListPT: getListPT, listPtName: list));
          }
        },
      );
    } else {
      emit(BtsPtIjazahNoInternetState());
    }
  }
}
