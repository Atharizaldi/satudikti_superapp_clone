import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getDetailMahasiswa.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getDetailMahasiswaReg.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStatusKuliah.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStudi.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/mahasiswa/getMahasiswaPageAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/mahasiswa/getMahasiswaPageAPIReg.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/mahasiswa/getRiwayatKuliahMahasiswa.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/mahasiswa/getRiwayatStudiMahasiswa.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_pencarian_mahasiswa_event.dart';
part 'detail_pencarian_mahasiswa_state.dart';

class DetailPencarianMahasiswaBloc
    extends Bloc<DetailPencarianMahasiswaEvent, DetailPencarianMahasiswaState> {
  GetMahasiswaPageAPI getMahasiswaPageAPIUseCase;
  GetMahasiswaPageAPIReg getMahasiswaPageAPIRegUseCase;
  GetRiwayatKuliahMahasiswa getRiwayatKuliahMahasiswaUseCase;
  GetRiwayatStudiMahasiswa getRiwayatStudiMahasiswaUseCase;
  var listDetailMahasiswa, riwayatKuliahMahasiswa, riwayatStudiMahasiswa;

  DetailPencarianMahasiswaBloc({
    required this.getMahasiswaPageAPIUseCase,
    required this.getMahasiswaPageAPIRegUseCase,
    required this.getRiwayatKuliahMahasiswaUseCase,
    required this.getRiwayatStudiMahasiswaUseCase,
  }) : super(InitDetailState()) {
    on<LoadDetailPencarianEvent>(_onLoadEvent);
  }

  void _onLoadEvent(LoadDetailPencarianEvent event,
      Emitter<DetailPencarianMahasiswaState> emit) async {
    try {
      final isConnected = await InternetCheck().hasConnection();
      final prefs = await SharedPreferences.getInstance();
      print("HASIL ISCONNECTED DETAIL: $isConnected");
      if (isConnected) {
        if (event.fromElasticGeneral) {
          await getMahasiswaPageAPIReg(event.nomorInduk);

          await getRiwayatKuliahMahasiswa(
              listDetailMahasiswa.data.mahasiswa[0].terdaftar.nim,
              listDetailMahasiswa.data.mahasiswa[0].terdaftar.kodePt,
              listDetailMahasiswa.data.mahasiswa[0].terdaftar.kodeProdi);

          await getRiwayatStudiMahasiswa(
              listDetailMahasiswa.data.mahasiswa[0].terdaftar.nim,
              listDetailMahasiswa.data.mahasiswa[0].terdaftar.kodePt,
              listDetailMahasiswa.data.mahasiswa[0].terdaftar.kodeProdi);
        } else {
          await getMahasiswaPageAPI(
              event.nomorInduk, event.kodePT, event.kodePD);
          await getRiwayatKuliahMahasiswa(
              event.nomorInduk, event.kodePT, event.kodePD);
          await getRiwayatStudiMahasiswa(
              event.nomorInduk, event.kodePT, event.kodePD);
        }
        emit(LoadedDetailState());
      } else {
        emit(NoInternetState());
      }
    } on SocketException {
      print('ON SocketException Detail Mahasiswa Bloc');
      emit(NoInternetState());
    } on Exception {
      print("ON Exception Detail Mahasiswa Bloc");
      emit(NoInternetState());
    }
  }

  Future<GetDetailMahasiswa?> getMahasiswaPageAPI(
      String nim, String kodePT, String kodePD) async {
    final result =
        await getMahasiswaPageAPIUseCase.execute(nim, kodePT, kodePD);
    return result.fold(
      (failure) async {
        listDetailMahasiswa = null;
      },
      (detailMahasiswa) async {
        listDetailMahasiswa = detailMahasiswa;
      },
    );
  }

  Future<GetDetailMahasiswaReg?> getMahasiswaPageAPIReg(String nim) async {
    final result = await getMahasiswaPageAPIRegUseCase.execute(nim);
    return result.fold(
      (failure) async {
        listDetailMahasiswa = null;
      },
      (detailMahasiswaReg) async {
        listDetailMahasiswa = detailMahasiswaReg;
      },
    );
  }

  Future<RiwayatStatusKuliah?> getRiwayatKuliahMahasiswa(
      String nim, String kodePT, String kodePD) async {
    final result =
        await getRiwayatKuliahMahasiswaUseCase.execute(nim, kodePT, kodePD);
    return result.fold(
      (failure) async {
        riwayatKuliahMahasiswa = null;
      },
      (riwayatKuliah) async {
        riwayatKuliahMahasiswa = riwayatKuliah;
      },
    );
  }

  Future<RiwayatStudiMahasiswa?> getRiwayatStudiMahasiswa(
      String nim, String kodePT, String kodePD) async {
    final result =
        await getRiwayatStudiMahasiswaUseCase.execute(nim, kodePT, kodePD);
    return result.fold(
      (failure) async {
        riwayatStudiMahasiswa = null;
      },
      (riwayatStudi) async {
        riwayatStudiMahasiswa = riwayatStudi;
      },
    );
  }
}
