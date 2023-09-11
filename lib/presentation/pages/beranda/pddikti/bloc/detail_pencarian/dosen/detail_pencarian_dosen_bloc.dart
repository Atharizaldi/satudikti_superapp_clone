import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getDetailDosen.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatMengajar.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/dosen/getDetailDosenPageAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/dosen/getRiwayatMengajarDosenAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/dosen/getRiwayatPendidikanDosenAPI.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_pencarian_dosen_event.dart';
part 'detail_pencarian_dosen_state.dart';

class DetailPencarianDosenBloc
    extends Bloc<DetailPencarianDosenEvent, DetailPencarianDosenState> {
  GetDetailDosenPageAPI getDetailDosenAPIUseCase;
  GetRiwayatPendidikanDosenAPI getRiwayatPendidikanDosenAPIUseCase;
  GetRiwayatMengajarDosenAPI getRiwayatMengajarDosenAPIUseCase;
  var listDetailDosen, riwayatPendidikanDosen;
  RiwayatMengajar? riwayatMengajarDosen;

  var riwayatStudiMahasiswa;

  DetailPencarianDosenBloc({
    required this.getDetailDosenAPIUseCase,
    required this.getRiwayatPendidikanDosenAPIUseCase,
    required this.getRiwayatMengajarDosenAPIUseCase,
  }) : super(InitDetailDosenState()) {
    on<LoadDetailPencarianDosenEvent>(_onLoadEvent);
  }

  void _onLoadEvent(LoadDetailPencarianDosenEvent event,
      Emitter<DetailPencarianDosenState> emit) async {
    try {
      final isConnected = await InternetCheck().hasConnection();
      print("HASIL ISCONNECTED DETAIL: $isConnected");
      if (isConnected) {
        await getDetailDosenAPI(event.nomorInduk);
        await getRiwayatMengajarDosenAPI(event.nomorInduk);
        await getRiwayatPendidikanDosenAPI(event.nomorInduk);
        emit(LoadedDetailState());
      } else {
        emit(NoInternetState());
      }
    } on SocketException {
      print('ON SocketException Detail Dosen Bloc');
      emit(NoInternetState());
    } on Exception {
      print("ON Exception Detail Dosen Bloc");
      emit(NoInternetState());
    }
  }

  Future<GetDetailDosen?> getDetailDosenAPI(String nidn) async {
    final result = await getDetailDosenAPIUseCase.execute(nidn);
    return result.fold(
      (failure) async {
        listDetailDosen = null;
      },
      (detailDosen) async {
        listDetailDosen = detailDosen;
      },
    );
  }

  Future<RiwayatMengajar?> getRiwayatMengajarDosenAPI(String nidn) async {
    final result = await getRiwayatMengajarDosenAPIUseCase.execute(nidn);
    return result.fold(
      (failure) async {
        riwayatMengajarDosen = null;
      },
      (riwayatMengajar) async {
        riwayatMengajarDosen = riwayatMengajar;
      },
    );
  }

  Future<GetDetailDosen?> getRiwayatPendidikanDosenAPI(String nidn) async {
    final result = await getRiwayatPendidikanDosenAPIUseCase.execute(nidn);
    return result.fold(
      (failure) async {
        riwayatPendidikanDosen = null;
      },
      (riwayatPendidikan) async {
        riwayatPendidikanDosen = riwayatPendidikan;
      },
    );
  }
}
