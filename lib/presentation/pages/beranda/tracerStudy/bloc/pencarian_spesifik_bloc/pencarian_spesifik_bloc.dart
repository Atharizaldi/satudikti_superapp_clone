import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/domain/usecases/tracer/getListElasticProvinsiTracer.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pencarian_spesifik_event.dart';
part 'pencarian_spesifik_state.dart';

class PencarianSpesifikTracerBloc
    extends Bloc<PencarianSpesifikTracerEvent, PencarianSpesifikState> {
  GetListElasticProvinsitracer getListElasticProvinsiUseCase;
  Map<String, String> hasilProvinsi = {};
  bool onPTSearch = false;

  PencarianSpesifikTracerBloc(
      {
      required this.getListElasticProvinsiUseCase,
      })
      : super(PencarianSpesifikInitialState()) {
    on<InitPencarianSpesifikEvent>(_initEvent);
  }

  void _initEvent(PencarianSpesifikTracerEvent event,
      Emitter<PencarianSpesifikState> emit) async {
    try {
      print('before result initevent');
      bool result = await InternetCheck().hasConnection();
      print('result');
      print(result);
      await getListProvinsi();

      if (result) {
        emit(PencarianSpesifikLoadedState());
      } else {
        emit(PencarianSpesifikNoInternetState());
      }
    } on SocketException {
      print('SocketException');
      emit(PencarianSpesifikNoInternetState());
    } on Exception {
      print('Exception');
      emit(PencarianSpesifikNoInternetState());
    }
  }

  Future<void> getListProvinsi() async {
    final result = await getListElasticProvinsiUseCase.execute();
    return result.fold((failure) async {
      print('fail on bloc prov');
      hasilProvinsi = {};
    }, (getListProvinsi) async {
      print('success on bloc prov');
      hasilProvinsi = getListProvinsi;
    });
  }

}
