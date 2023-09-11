
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListProdi.dart';
import 'package:app/domain/usecases/tracer/getListProdiTracer.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_prodi_bloc/pencarian_prodi_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pencarian_prodi_event.dart';

class PencarianProdiTracerBloc
    extends Bloc<PencarianProdiTracerEvent, PencarianProdiTracerState> {
  GetListProdiTracer getListProdiUsecase;


  PencarianProdiTracerBloc(
      {
        required this.getListProdiUsecase,
      })
      : super(PencarianProdiTracerLoadingState()) {
        on<GetListProdiTracerEvent>(_getListProdi);
  }
  
  
  void _getListProdi(
      GetListProdiTracerEvent event, Emitter<PencarianProdiTracerState> emit) async {
    emit(PencarianProdiTracerLoadingState());
    final hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      List<DataProdiTracer> listProdi = [];
      final resultProdi = await getListProdiUsecase.execute(event.kodePT!, event.keyword!);
      resultProdi.fold((failure) {
        emit(PencarianProdiTracerErrorState());
      }, (response) {
        listProdi = response;
      });

      if (listProdi.isNotEmpty) {
        emit(PencarianProdiTracerLoadedState(
            listProdi: listProdi,
        ));
      }
    } else {
      emit(PencarianProdiTracerNoInternetState());
    }
  }

}
