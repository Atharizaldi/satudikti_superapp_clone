import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/domain/usecases/pddikti/result/getDetailDosenAPI.dart';
import 'package:app/domain/usecases/pddikti/result/getDetailMahasiswaAPI.dart';
import 'package:app/domain/usecases/pddikti/result/getPTAPI.dart';
import 'package:app/domain/usecases/pddikti/result/getProdiAPI.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'result_spesifik_event.dart';
part 'result_spesifik_state.dart';

class ResultSpesifikBloc
    extends Bloc<ResultSpesifikEvent, ResultSpesifikState> {
  GetPTAPI getPTAPIUseCase;
  GetProdiAPI getProdiAPIUseCase;
  GetDetailMahasiswaAPI getDetailMahasiswaAPIUseCase;
  GetDetailDosenAPI getDetailDosenAPIUseCase;
  var listMahasiswa, listDosen, listProdi, listPT;

  ResultSpesifikBloc({
    required this.getPTAPIUseCase,
    required this.getProdiAPIUseCase,
    required this.getDetailMahasiswaAPIUseCase,
    required this.getDetailDosenAPIUseCase,
  }) : super(ResultSpesifikLoadingState()) {
    on<LoadResultSpesifikEvent>(_loadEvent);
    on<LoadMahasiswaResultEvent>(_loadMahasiswaEvent);
    on<LoadDosenResultEvent>(_loadDosenEvent);
    on<LoadPTResultEvent>(_loadPTEvent);
    on<LoadProdiResultEvent>(_loadProdiEvent);
  }

  void _loadEvent(
      LoadResultSpesifikEvent event, Emitter<ResultSpesifikState> emit) async {
    bool result = await InternetCheck().hasConnection();
    try {
      if (result) {
        emit(ResultSpesifikLoadedState());
      } else {
        emit(ResultSpesifikNoInternetState());
      }
    } on SocketException {
      print('SocketException');
      emit(ResultSpesifikNoInternetState());
    } on Exception {
      print('Exception');
      emit(ResultSpesifikNoInternetState());
    }
  }

  void _loadMahasiswaEvent(
      LoadMahasiswaResultEvent event, Emitter<ResultSpesifikState> emit) async {
    try {
      bool result = await InternetCheck().hasConnection();
      if (result) {
        await getDetailMahasiswaAPI(
          event.nama!,
          event.nomorInduk!,
          event.kodePT!,
          event.kodePD!,
        );
        if (listMahasiswa == null) {
          emit(ResultSpesifikNotFoundState());
        } else {
          emit(ResultMahasiswaLoadedState());
        }
      } else {
        emit(ResultSpesifikNoInternetState());
      }
    } on SocketException {
      print('SocketException');
      emit(ResultSpesifikNoInternetState());
    } on Exception {
      print('Exception');
      emit(ResultSpesifikNoInternetState());
    }
  }

  void _loadDosenEvent(
      LoadDosenResultEvent event, Emitter<ResultSpesifikState> emit) async {
    try {
      bool result = await InternetCheck().hasConnection();

      if (result) {
        await getDetailDosenAPI(
          event.nama ?? '',
          event.nomorInduk ?? '',
          event.kodePT ?? '',
        );
        print("AFTER getdetialdosenapi ${listDosen}");
        if (listDosen == null) {
          emit(ResultSpesifikNotFoundState());
        } else {
          emit(ResultDosenLoadedState());
        }
      } else {
        emit(ResultSpesifikNoInternetState());
      }
    } on SocketException {
      print('SocketException');
      emit(ResultSpesifikNoInternetState());
    } on Exception {
      print('Exception');
      emit(ResultSpesifikNoInternetState());
    }
  }

  void _loadPTEvent(
      LoadPTResultEvent event, Emitter<ResultSpesifikState> emit) async {
    try {
      bool result = await InternetCheck().hasConnection();
      if (result) {
        await getPTAPI(event.kodePT, event.kodeProvinsi, event.tipePT);
        if (listPT == null) {
          emit(ResultSpesifikNotFoundState());
        } else {
          emit(ResultPTLoadedState());
        }
      } else {
        emit(ResultSpesifikNoInternetState());
      }
    } on SocketException {
      print('SocketException');
      emit(ResultSpesifikNoInternetState());
    } on Exception {
      print('Exception');
      emit(ResultSpesifikNoInternetState());
    }
  }

  void _loadProdiEvent(
      LoadProdiResultEvent event, Emitter<ResultSpesifikState> emit) async {
    try {
      bool result = await InternetCheck().hasConnection();
      if (result) {
        await getProdiAPI(
            event.namaProdi, event.kodePT!, event.akreditasi!, event.jenjang!);
        if (listProdi == null) {
          emit(ResultSpesifikNotFoundState());
        } else {
          emit(ResultProdiLoadedState());
        }
      } else {
        emit(ResultSpesifikNoInternetState());
      }
    } on SocketException {
      print('SocketException');
      emit(ResultSpesifikNoInternetState());
    } on Exception {
      print('Exception');
      emit(ResultSpesifikNoInternetState());
    }
  }

  Future<void> getDetailMahasiswaAPI(
      String nama, String nim, String kodePT, String kodePD) async {
    final result =
        await getDetailMahasiswaAPIUseCase.execute(nama, nim, kodePT, kodePD);
    return result.fold((failure) {
      print('fail on bloc getDetailMahasiswaAPI');
      listMahasiswa = null;
    }, (lstMahasiswa) {
      print('success on bloc getDetailMahasiswaAPI');
      listMahasiswa = lstMahasiswa;
    });
  }

  Future<void> getDetailDosenAPI(
      String nama, String nidn, String kodePT) async {
    final result = await getDetailDosenAPIUseCase.execute(nama, nidn, kodePT);
    return result.fold((failure) {
      print('fail on bloc dosen');
      listDosen = null;
    }, (lstDosen) {
      print('success on bloc dosen');
      listDosen = lstDosen;
    });
  }

  Future<void> getPTAPI(String npsn, String kodeProvinsi, String tipePT) async {
    final result = await getPTAPIUseCase.execute(npsn, kodeProvinsi, tipePT);
    return result.fold((failure) {
      print('fail on bloc getPTAPI');
      listPT = null;
    }, (getListProvinsi) {
      print('success on bloc getPTAPI');
      listPT = getListProvinsi;
    });
  }

  Future<void> getProdiAPI(String namaProdi, String kodePT, String akreditasi,
      String jenjang) async {
    final result = await getProdiAPIUseCase.execute(
        namaProdi, kodePT, akreditasi, jenjang);
    return result.fold((failure) {
      print('fail on bloc getProdiAPI');
      listProdi = null;
    }, (getListProvinsi) {
      print('success on bloc getProdiAPI');
      listProdi = getListProvinsi;
    });
  }
}

enum Types { Mahasiswa, Dosen, PT, Prodi }
