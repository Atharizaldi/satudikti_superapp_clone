import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/siaga/searchTracking.dart';
import 'package:app/domain/usecases/siaga/getSearchTrackingUsulan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'pt_event.dart';
part 'pt_state.dart';

class PtBloc extends Bloc<PtEvent, PtState> {
  GetSearchTrackingUsulan getSearchListPT;

  PtBloc({required this.getSearchListPT}) : super(PtNotFoundState()) {
    on<SearchPtEvent>(_searchPt);
  }

  void _searchPt(SearchPtEvent event, Emitter<PtState> emit) async {
    Logger().d("_searchPt: ${event.query}");
    emit(PtLoadingState());
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      final result = await getSearchListPT.execute(event.query);
      await result.fold(
            (failure) async {
          emit(PtNotFoundState());
        },
            (getListPT) async {
          List<String> list = getListPT.data.map((e)=> e.label).toList();
          emit(PtLoadedState(getListPT: getListPT, listPtName: list));
          Logger().d("pt length : ${list.length}");
        },
      );
    } else {
      emit(PtNoInternetState());
    }
  }
}

