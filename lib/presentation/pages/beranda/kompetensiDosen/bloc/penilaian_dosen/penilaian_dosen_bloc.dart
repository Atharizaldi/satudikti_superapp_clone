import 'dart:async';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/penilaian_dosen.dart';
import 'package:app/domain/usecases/kompetensi_dosen/download_sertifikat.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_penilaian_dosen.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_sertifikat.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'penilaian_dosen_event.dart';
part 'penilaian_dosen_state.dart';

class PenilaianDosenBloc
    extends Bloc<PenilaianDosenEvent, PenilaianDosenState> {
  GetPenilaianDosen getPenilaianDosenUseCase;
  GetSertifikat getSertifikatUseCase;
  InternetCheck internetCheck;
  DownloadSertifikat downloadSertifikatUseCase;
  PenilaianDosenBloc({
    required this.getPenilaianDosenUseCase,
    required this.getSertifikatUseCase,
    required this.downloadSertifikatUseCase,
    required this.internetCheck,
  }) : super(PenilaianDosenInitial()) {
    on<GetPenilaianDosenEvent>(_onGetPenilaianDosen);
    on<GetSertifikatEvent>(_onGetSertifikat);
  }
  FutureOr<void> _onGetPenilaianDosen(
      GetPenilaianDosenEvent event, Emitter<PenilaianDosenState> emit) async {
    print("event id GET PNILAIAN ${event.id}");
    final isConnected = await internetCheck.hasConnection();

    if (isConnected) {
      final result = await getPenilaianDosenUseCase.execute(event.id);

      result.fold((failure) {
        emit(PenilaianDosenError());
      }, (response) {
        print("success _onGetPenilaianDosen response $response");
        emit(PenilaianDosenLoaded(penilaianDosen: response));
      });
    } else {
      emit(PenilaianDosenNoInternet());
    }
  }

  void _onGetSertifikat(
      GetSertifikatEvent event, Emitter<PenilaianDosenState> emit) async {
    downloadSertifikatUseCase.execute(event.id);
  }
}
