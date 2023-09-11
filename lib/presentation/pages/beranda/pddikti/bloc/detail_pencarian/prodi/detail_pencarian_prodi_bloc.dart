import 'dart:async';
import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAkreditasiPT.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getDetailProdi.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getDetailProdiReg.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListDosenProdi.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getRasioMhsDosen.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getAkreditasiProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getDetailProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getDetailProdiAPIReg.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getListDosenProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getRasioProdiAPI.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_pencarian_prodi_event.dart';
part 'detail_pencarian_prodi_state.dart';

class DetailPencarianProdiBloc
    extends Bloc<DetailPencarianProdiEvent, DetailPencarianProdiState> {
  GetAkreditasiProdiAPI getAkreditasiProdiAPIUseCase;
  GetDetailProdiAPI getDetailProdiAPIUseCase;
  GetDetailProdiAPIReg getDetailProdiAPIRegUseCase;
  GetListDosenProdiAPI getListDosenProdiAPIUseCase;
  GetRasioProdiAPI getRasioProdiAPIUseCase;

  var listProdi, listDosen, listRasio, listAkreditasi;
  bool detailTabIsNull = false;
  bool haveAkreditasi = false;
  bool haveRasio = false;

  String kodePT = "";
  String kodeProdi = "";

  DetailPencarianProdiBloc({
    required this.getAkreditasiProdiAPIUseCase,
    required this.getDetailProdiAPIUseCase,
    required this.getDetailProdiAPIRegUseCase,
    required this.getListDosenProdiAPIUseCase,
    required this.getRasioProdiAPIUseCase,
  }) : super(InitDetailProdiState()) {
    on<LoadPencarianProdiEvent>(_onLoadEvent);
    on<LoadPencarianProdiRegEvent>(_onLoadRegEvent);
  }

  void _onLoadEvent(LoadPencarianProdiEvent event,
      Emitter<DetailPencarianProdiState> emit) async {
    try {
      final isConnected = await InternetCheck().hasConnection();
      if (isConnected) {
        await getDetailProdiAPI(event.kodeProdi, event.kodePT, event.fromPT);

        await getAkreditasiProdiAPI(event.kodeProdi, event.kodePT);
        await getListDosenProdiAPI(event.kodeProdi, event.kodePT);
        await getRasioProdiAPI(event.kodeProdi, event.kodePT, event.fromPT);
        print("INI EVENT KODEPT = ${event.kodePT}");
        print("HAVEE AKREDIITT $haveAkreditasi");
        emit(LoadedDetailProdiState());
      } else {
        emit(NoInternetProdiState());
      }
    } on SocketException {
      print('ON SocketException Detail Prodi Bloc');
      emit(NoInternetProdiState());
    } on Exception {
      print("ON Exception Detail Prodi Bloc");
      emit(NoInternetProdiState());
    }
  }

  void _onLoadRegEvent(LoadPencarianProdiRegEvent event,
      Emitter<DetailPencarianProdiState> emit) async {
    try {
      final isConnected = await InternetCheck().hasConnection();
      if (isConnected) {
        await getDetailProdiAPIReg(event.idReg);
        if (listProdi == null) {
          emit(NotFoundProdiState());
        } else {
          kodePT = listProdi.data.prodi[0].pt.kode;
          kodeProdi = listProdi.data.prodi[0].kode;

          await getAkreditasiProdiAPI(kodeProdi, kodePT);
          await getListDosenProdiAPI(kodeProdi, kodePT);
          await getRasioProdiAPI(kodeProdi, kodePT, event.fromPT);

          emit(LoadedDetailProdiState());
        }
      } else {
        emit(NoInternetProdiState());
      }
    } on SocketException {
      print('ON SocketException Detail Prodi Bloc');
      emit(NoInternetProdiState());
    } on Exception {
      print("ON Exception Detail Prodi Bloc");
      emit(NoInternetProdiState());
    }
  }

  Future<GetDetailProdi?> getDetailProdiAPI(
      String kodeProdi, String kodePT, bool fromPT) async {
    if (fromPT == false) {
      kodePT = kodePT.substring(0, 6);
    }

    final result =
        await getDetailProdiAPIUseCase.execute(kodeProdi, kodePT, fromPT);
    return result.fold(
      (failure) async {
        listProdi = null;
      },
      (prodi) async {
        listProdi = prodi;
        isListProdiNull(listProdi);
      },
    );
  }

  Future<GetDetailProdiReg?> getDetailProdiAPIReg(String idReg) async {
    final result = await getDetailProdiAPIRegUseCase.execute(idReg);
    return result.fold(
      (failure) async {
        listProdi = null;
      },
      (prodiReg) async {
        listProdi = prodiReg;
      },
    );
  }

  void isListProdiNull(dynamic listProdi) {
    print("LISTPRODI DETAIL $listProdi");
    if (listProdi.data.prodi.deskripsi == "" &&
        listProdi.data.prodi.visi == "" &&
        listProdi.data.prodi.misi == "" &&
        listProdi.data.prodi.kompetensi == "") {
      detailTabIsNull = true;
    }
  }

  Future<GetAkreditasiPT?> getAkreditasiProdiAPI(
      String kodeProdi, String kodePT) async {
    final result =
        await getAkreditasiProdiAPIUseCase.execute(kodeProdi, kodePT);
    return result.fold(
      (failure) async {
        listAkreditasi = null;
        haveAkreditasi = false;
      },
      (akreditasi) async {
        listAkreditasi = akreditasi;
        haveAkreditasi = true;
      },
    );
  }

  Future<GetRasioMhsDosen?> getRasioProdiAPI(
      String kodeProdi, String kodePT, bool fromPT) async {
    if (!fromPT) {
      kodePT = kodePT.substring(0, kodePT.length);
    }
    final result = await getRasioProdiAPIUseCase.execute(kodeProdi, kodePT);
    return result.fold(
      (failure) async {
        listRasio = '-';
        haveRasio = false;
      },
      (rasio) async {
        listRasio = rasio;
        haveRasio = true;
      },
    );
  }

  Future<GetListDosenProdi?> getListDosenProdiAPI(
      String kodeProdi, String kodePT) async {
    final result = await getListDosenProdiAPIUseCase.execute(kodeProdi, kodePT);
    return result.fold(
      (failure) async {
        listDosen = null;
      },
      (dosen) async {
        listDosen = dosen;
      },
    );
  }
}
