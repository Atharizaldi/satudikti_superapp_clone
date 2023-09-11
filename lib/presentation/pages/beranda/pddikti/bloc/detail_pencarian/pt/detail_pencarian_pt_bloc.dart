import 'dart:convert';
import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/IDPTPDDIKTI.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAgregatPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAkreditasiPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getDetailPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getPelaporanPT.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getAgregatPTAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getAkreditasiPTAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getDetailPTAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getIDPTPDDIKTI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getPelaporanPTAPI.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

part 'detail_pencarian_pt_event.dart';
part 'detail_pencarian_pt_state.dart';

class DetailPencarianPtBloc
    extends Bloc<DetailPencarianPtEvent, DetailPencarianPtState> {
  GetAgregatPTAPI getAgregatPTAPIUseCase;
  GetAkreditasiPTAPI getAkreditasiPTAPIUseCase;
  GetDetailPTAPI getDetailPTAPIUseCase;
  GetPelaporanPTAPI getPelaporanPTAPIUseCase;
  GetIDPTPDDIKTI getIDPTPDDIKTI;
  var listDetailPT, listAkreditasiPT, listAgregatPT, listPelaporanPT;
  bool hasAkreditasi = false;
  bool hasAgregat = false;
  bool hasPelaporan = false;
  Logger log;
  InternetCheck internetCheck;

  var imagePT;

  DetailPencarianPtBloc({
    required this.getAgregatPTAPIUseCase,
    required this.getAkreditasiPTAPIUseCase,
    required this.getDetailPTAPIUseCase,
    required this.getPelaporanPTAPIUseCase,
    required this.log,
    required this.internetCheck,
    required this.getIDPTPDDIKTI,
  }) : super(InitDetailPTState()) {
    on<LoadPencarianEvent>(_onLoadEvent);
    on<IDPTPDDIKTIEvent>(_getID);
  }
  void _getID(
      IDPTPDDIKTIEvent event, Emitter<DetailPencarianPtState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();

    if (hasInternet) {
      emit(LoadingPTState());
      print("KESINI LOG");
      if (event.id == '') {
        emit(NotFoundPTState());
      } else {
        final result = await getIDPTPDDIKTI.execute(event.id);
        await result.fold(
          (failure) async {
            log.d('LoggedInBloc - error di majalah bloc: $state');
            log.d('LoggedInBloc - failure msg: ${failure.message}');
            if (failure.message == 'error500') {
              emit(ErrorPTState());
            } else if (failure.message == 'error404') {
              emit(NotFoundPTState());
            } else if (failure.message == '') {
              emit(ErrorPTState());
            }
          },
          (idPTPDDIKTI) async {
            emit(IDPTLoaded(idptpddikti: idPTPDDIKTI.data.perguruanTinggi));
          },
        );
      }
    } else {
      emit(NoInternetPTState());
    }
  }

  void _onLoadEvent(
      LoadPencarianEvent event, Emitter<DetailPencarianPtState> emit) async {
    try {
      final isConnected = await InternetCheck().hasConnection();
      print("HASIL ISCONNECTED DETAIL: $isConnected");
      if (isConnected) {
        await getDetailPTAPI(event.kodePT, event.fromSpecific);
        if (listDetailPT.data.perguruanTinggi.id != null) {
          getImagePT(listDetailPT.data.perguruanTinggi.urlLogo);
          await getAgregatPTAPI(listDetailPT.data.perguruanTinggi.id);
          await getAkreditasiPTAPI(listDetailPT.data.perguruanTinggi.id);
          await getPelaporanPTAPI(listDetailPT.data.perguruanTinggi.id);
        } else {
          emit(NotFoundPTState());
        }

        emit(LoadedDetailPTState());
      } else {
        emit(NoInternetPTState());
      }
    } on SocketException {
      print('ON SocketException Detail PT Bloc');
      emit(NoInternetPTState());
    } on Exception {
      print("ON Exception Detail PT Bloc");
      emit(NoInternetPTState());
    }
  }

  Future<GetDetailPT?> getDetailPTAPI(String kodePT, bool fromSpecific) async {
    if (fromSpecific) {
      kodePT = kodePT.substring(0, 6);
    }
    final result = await getDetailPTAPIUseCase.execute(kodePT);
    return result.fold(
      (failure) async {
        listDetailPT = null;
      },
      (detailPT) async {
        listDetailPT = detailPT;
      },
    );
  }

  Future<GetAgregatPT?> getAgregatPTAPI(String ptId) async {
    final result = await getAgregatPTAPIUseCase.execute(ptId);
    return result.fold(
      (failure) async {
        listAgregatPT = null;
        hasAgregat = false;
      },
      (agregatPT) async {
        listAgregatPT = agregatPT;
        hasAgregat = true;
      },
    );
  }

  Future<GetAkreditasiPT?> getAkreditasiPTAPI(String ptId) async {
    final result = await getAkreditasiPTAPIUseCase.execute(ptId);
    return result.fold(
      (failure) async {
        listAkreditasiPT = null;
        hasAkreditasi = false;
      },
      (akreditasiPT) async {
        listAkreditasiPT = akreditasiPT;
        hasAkreditasi = true;
      },
    );
  }

  Future<GetPelaporanPT?> getPelaporanPTAPI(String ptId) async {
    final result = await getPelaporanPTAPIUseCase.execute(ptId);
    return result.fold(
      (failure) async {
        listPelaporanPT = null;
        hasPelaporan = false;
      },
      (pelaporanPT) async {
        listPelaporanPT = pelaporanPT;
        hasPelaporan = true;
      },
    );
  }

  void getImagePT(String urlLogo) {
    print('URLLOGO : $urlLogo');
    if (urlLogo != '') {
      imagePT = Image.memory(
        base64Decode(urlLogo),
        height: 47.h,
      );
    }
  }
}
