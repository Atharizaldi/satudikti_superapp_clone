import 'dart:async';
import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sivil/sivilList.dart';
import 'package:app/domain/usecases/sivil/getSivil.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hasil_sivil_event.dart';
part 'hasil_sivil_state.dart';

class HasilSivilBloc extends Bloc<HasilSivilEvent, HasilSivilState> {
  GetSivil getSivilUseCase;
  Sivil? sivil;
  bool _isSucceeded = false;

  HasilSivilBloc({required this.getSivilUseCase})
      : super(InitHasilSivilState()) {
    on<LoadHasilSivilEvent>(_onLoadEvent);
  }

  void _onLoadEvent(
      LoadHasilSivilEvent event, Emitter<HasilSivilState> emit) async {
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      try {
        await getSivil(event.kodePT, event.kodeProdi, event.noIjazah);
        if (!_isSucceeded) {
          emit(NotFoundHasilSivilState());
        } else {
          emit(LoadedHasilSivilState());
        }
      } on SocketException {
        print('Socket exception hasil sivil');
        emit(NoInternetHasilSivilState());
      } on Exception {
        print('Exception hasil sivil');
        emit(NoInternetHasilSivilState());
      }
    } else {
      emit(NoInternetHasilSivilState());
    }
  }

  Future<Sivil?> getSivil(
      String kodePt, String kodeProdi, String? noIjazah) async {
    final result = await getSivilUseCase.execute(kodePt, kodeProdi, noIjazah);
    return result.fold((failure) async {
      sivil = null;
      _isSucceeded = false;
    }, (hasilSivil) async {
      sivil = hasilSivil;
      _isSucceeded = true;
    });
  }
}
