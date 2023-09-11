import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListKabupaten.dart';
import 'package:app/domain/usecases/tracer/getListElasticKabupaten.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_kabupaten_bloc/pencarian_kabupaten_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'pencarian_kabupaten_event.dart';

class PencarianKabupatenTracerBloc
    extends Bloc<PencarianKabupatenTracerEvent, PencarianKabupatenTracerState> {
  GetListElasticKabupaten getListKabupatenUsecase;
  Map<String, String> hasilKabupaten = {};

  PencarianKabupatenTracerBloc({
    required this.getListKabupatenUsecase,
  }) : super(PencarianKabupatenTracerLoadingState()) {
    on<GetListKabupatenTracerEvent>(_getListKabupaten);
  }

  void _getListKabupaten(GetListKabupatenTracerEvent event,
      Emitter<PencarianKabupatenTracerState> emit) async {
    emit(PencarianKabupatenTracerLoadingState());
    final hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      List<Kabupaten> listKabupaten = [];
      final resultKabupaten =
          await getListKabupatenUsecase.execute(event.kodeProv!);
      resultKabupaten.fold((failure) {
        emit(PencarianKabupatenTracerErrorState());
      }, (response) {
        Logger().i(response);
        listKabupaten = response;
      });

      if (listKabupaten.isNotEmpty) {
        hasilKabupaten.clear();
        for (int i = 0; i < listKabupaten.length; i++) {
          hasilKabupaten[listKabupaten[i].kabKota] =
              listKabupaten[i].kodeKabKota;
        }
        emit(PencarianKabupatenTracerLoadedState(
            listKabupaten: listKabupaten, hasilKabupaten: hasilKabupaten));
      }
    } else {
      emit(PencarianKabupatenTracerNoInternetState());
    }
  }
}
