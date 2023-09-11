
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListPT.dart';
import 'package:app/domain/usecases/tracer/getListPtTracer.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_pt_bloc/pencarian_pt_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pencarian_pt_event.dart';

class PencarianPtTracerBloc
    extends Bloc<PencarianPtTracerEvent, PencarianPtTracerState> {
  GetListPtTracer getListPtUsecase;


  PencarianPtTracerBloc(
      {
        required this.getListPtUsecase,
      })
      : super(PencarianPtTracerLoadingState()) {
        on<GetListPtTracerEvent>(_getListPt);
  }
  
  
  void _getListPt(
      GetListPtTracerEvent event, Emitter<PencarianPtTracerState> emit) async {
    emit(PencarianPtTracerLoadingState());
    final hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      List<DataPtTracer> listPt = [];
      final resultPt = await getListPtUsecase.execute(event.keyword!);
      resultPt.fold((failure) {
        emit(PencarianPtTracerErrorState());
      }, (response) {
        listPt = response;
      });

      if (listPt.isNotEmpty) {
        emit(PencarianPtTracerLoadedState(
            listPt: listPt,
        ));
      }
    } else {
      emit(PencarianPtTracerNoInternetState());
    }
  }

}
