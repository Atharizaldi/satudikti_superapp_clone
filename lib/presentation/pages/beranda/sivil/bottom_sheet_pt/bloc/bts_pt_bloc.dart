import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/domain/usecases/sivil/getSearchListPT.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'bts_pt_event.dart';
part 'bts_pt_state.dart';

class BtsPtBloc extends Bloc<BtsPtEvent, BtsPtState> {
  GetSearchListPT getSearchListPTUseCase;

  BtsPtBloc({required this.getSearchListPTUseCase})
      : super(BtsPtNotFoundState()) {
    on<BtsSearchPtEvent>(_searchPt);
  }

  void _searchPt(BtsSearchPtEvent event, Emitter<BtsPtState> emit) async {
    Logger().d("_searchPt: ${event.query}");
    emit(BtsPtLoadingState());
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      final result = await getSearchListPTUseCase.execute(event.query);
      await result.fold(
        (failure) async {
          emit(BtsPtNotFoundState());
        },
        (getListPT) async {
          List<String> list =
              getListPT.data.perguruanTinggi.map((e) => e.nama).toList();
          emit(BtsPtLoadedState(getListPT: getListPT, listPtName: list));
          Logger().d("pt length : ${list.length}");
        },
      );
    } else {
      emit(BtsPtNoInternetState());
    }
  }
}
