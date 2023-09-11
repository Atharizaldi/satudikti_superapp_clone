import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/siaga/detailTrackingUsulan.dart';
import 'package:app/domain/usecases/siaga/getDetailTrackingUsulan.dart';
import 'package:app/presentation/pages/beranda/siaga/pengajuanUsulan/bloc/pengajuan_usulan_event.dart';
import 'package:app/presentation/pages/beranda/siaga/pengajuanUsulan/bloc/pengajuan_usulan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanUsulanBloc
    extends Bloc<PengajuanUsulanEvent, PengajuanUsulanState> {
  GetDetailTrackingUsulan getSiagaUseCase;
  var listSiaga;
  bool _isSucceeded = false;

  PengajuanUsulanBloc({required this.getSiagaUseCase})
      : super(InitPengajuanUsulanState()) {
    on<LoadPengajuanUsulanEvent>(_onLoadEvent);
  }

  void _onLoadEvent(LoadPengajuanUsulanEvent event,
      Emitter<PengajuanUsulanState> emit) async {
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      try {
        await getSiaga(urlStagging, event.kataKunci);
        if (!_isSucceeded) {
          emit(NotFoundPengajuanUsulanState());
          print("not found siaga");
        } else {
          emit(LoadedPengajuanUsulanState());
          print("loaded siaga");
        }
      } on SocketException {
        print('Socket exception hasil siaga');
        emit(NoInternetPengajuanUsulanState());
      } on Exception {
        print('Exception hasil siaga');
        emit(NoInternetPengajuanUsulanState());
      }
    } else {
      emit(NoInternetPengajuanUsulanState());
    }
  }

  Future<StatusPengajuanUsulan?> getSiaga(String ip, String kataKunci) async {
    final result = await getSiagaUseCase.execute(kataKunci);
    return result.fold((failure) async {
      listSiaga = null;
      _isSucceeded = false;
    }, (hasilSiaga) async {
      listSiaga = hasilSiaga;
      _isSucceeded = true;
    });
  }
}
