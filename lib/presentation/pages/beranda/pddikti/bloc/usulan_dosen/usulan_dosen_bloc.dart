import 'dart:async';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/status_usulan_dosen/usulan_dosen.dart';
import 'package:app/domain/usecases/pddikti/usulan_dosen/get_usulan_dosen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'usulan_dosen_event.dart';
part 'usulan_dosen_state.dart';

class UsulanDosenBloc extends Bloc<UsulanDosenEvent, UsulanDosenState> {
  InternetCheck internetCheck;
  GetUsulanDosen getUsulanDosenUseCase;
  Logger log;
  String nama = '';
  String tglLahir = '';
  String idPT = '';
  String nidn = '';
  String isLogin = 'false';

  UsulanDosenBloc({
    required this.internetCheck,
    required this.log,
    required this.getUsulanDosenUseCase,
  }) : super(UsulanDosenInitial()) {
    on<GetUsulanDosenEvent>(_getUsulanDosen);
  }

  FutureOr<void> _getUsulanDosen(
      GetUsulanDosenEvent event, Emitter<UsulanDosenState> emit) async {
    final isConnected = await internetCheck.hasConnection();
    if (isConnected) {
      final result = await getUsulanDosenUseCase.execute(event.namaDosen,
          event.tanggalLahir, event.idPT, event.nidn, event.isLogin);
      nama = event.namaDosen;
      tglLahir = event.tanggalLahir;
      idPT = event.idPT;
      nidn = event.nidn;
      isLogin = event.isLogin;

      result.fold((failure) {
        log.d('LoggedInBloc - error di profile: $state');
        log.d('LoggedInBloc - failure msg: ${failure.message}');
        if (failure.message == 'error500') {
          emit(UsulanDosenError());
        } else if (failure.message == 'error404') {
          emit(UsulanDosenNotFound());
        } else if (failure.message == '') {
          emit(UsulanDosenError());
        }
      }, (usulanDosenResponse) {
        List<UsulanDosen> listSemua =
            usulanDosenResponse.data?.listUsulanDosen ?? [];
        List<UsulanDosen> listDraft = listSemua
            .where((usulan) => usulan.status?.trim() == "Draft")
            .toList();
        List<UsulanDosen> listDisetujui = listSemua
            .where((usulan) => usulan.status?.trim() == "Disetujui")
            .toList();
        List<UsulanDosen> listDiusulkan = listSemua
            .where((usulan) => usulan.status?.trim() == "Diusulkan")
            .toList();
        List<UsulanDosen> listDitolak = listSemua
            .where((usulan) => usulan.status?.trim() == "Ditolak")
            .toList();
        List<UsulanDosen> listDitangguhkan = listSemua
            .where((usulan) => usulan.status?.trim() == "Ditangguhkan")
            .toList();
        emit(
          UsulanDosenLoaded(
            listSemua: listSemua,
            listDraft: listDraft,
            listDisetujui: listDisetujui,
            listDiusulkan: listDiusulkan,
            listDitolak: listDitolak,
            listDitangguhkan: listDitangguhkan,
          ),
        );
      });
    } else {
      emit(UsulanDosenNoInternet());
    }
  }
}
