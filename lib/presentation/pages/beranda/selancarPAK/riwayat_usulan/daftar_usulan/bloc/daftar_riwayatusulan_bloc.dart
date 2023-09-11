import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:app/domain/usecases/selancar/get_usulan_detail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'daftar_riwayatusulan_event.dart';
part 'daftar_riwayatusulan_state.dart';

class DaftarRiwayatusulanBloc
    extends Bloc<DaftarRiwayatusulanEvent, DaftarRiwayatusulanState> {
  GetUsulanDetail getUsulanDetail;
  InternetCheck internetCheck;
  Logger log;
  DaftarRiwayatusulanBloc({
    required this.getUsulanDetail,
    required this.internetCheck,
    required this.log,
  }) : super(DaftarRiwayatusulanInitial()) {
    on<FetchDetailUsulanEvent>(_getDetailUsulan);
  }

  void _getDetailUsulan(FetchDetailUsulanEvent event,
      Emitter<DaftarRiwayatusulanState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      for (int j = 0; j < event.usulanList.length; j++) {
        print(event.usulanList[j].id);
      }
      int i = 0;
      List<UsulanDetail> usulanDetailList = [];
      do {
        final result = await getUsulanDetail.execute(
          event.nidn,
          event.usulanList[i].id,
        );
        await result.fold(
          (failure) async {
            log.d('LoggedInBloc - error di usulandetail: $state');
            log.d('LoggedInBloc - failure msg: ${failure.message}');
            if (failure.message == 'error500') {
              emit(DaftarRiwayatusulanErrorState(
                nidn: event.nidn,
                usulanList: event.usulanList,
              ));
            } else {
              emit(DaftarRiwayatusulanNoInternetState(
                nidn: event.nidn,
                usulanList: event.usulanList,
              ));
            }
          },
          (usulanDetail) async {
            log.d('LoggedInBloc - masuk ke usulandetail: $state');
            if (state is DaftarRiwayatusulanInitial ||
                state is DaftarRiwayatusulanLoadedState) {
              usulanDetailList.add(usulanDetail);
            } else {
              emit(DaftarRiwayatusulanErrorState(
                nidn: event.nidn,
                usulanList: event.usulanList,
              ));
            }
          },
        );

        i++;
      } while (i < event.usulanList.length &&
          (state is DaftarRiwayatusulanLoadedState ||
              state is DaftarRiwayatusulanInitial));

      emit(DaftarRiwayatusulanLoadedState(
        usulanList: event.usulanList,
        usulanDetail: usulanDetailList,
        nidn: event.nidn,
      ));
    } else {
      emit(DaftarRiwayatusulanNoInternetState(
        nidn: event.nidn,
        usulanList: event.usulanList,
      ));
    }
  }
}
