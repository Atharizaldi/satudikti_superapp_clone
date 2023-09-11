import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sister/bkd_rekrutmen_sister.dart';
import 'package:app/domain/usecases/sister/get_bkd_rekrutmen_sister.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'bkd_event.dart';
part 'bkd_state.dart';

class BKDSisterBloc extends Bloc<BKDSisterEvent, BKDSisterState> {
  GetBKDRekrutmenSister getBKDRekrutmenSister;

  Logger log;
  InternetCheck internetCheck;
  String nidn = '';

  BKDSisterBloc({
    required this.getBKDRekrutmenSister,
    required this.log,
    required this.internetCheck,
  }) : super(BKDSisterInitial()) {
    on<GetBKDSisterEvent>(_getBKD);
  }

  void _getBKD(GetBKDSisterEvent event, Emitter<BKDSisterState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      emit(BKDSisterLoading());
      nidn = event.nidn;
      final result = await getBKDRekrutmenSister.execute(event.nidn);
      final result1 = await getBKDRekrutmenSister.execute1(
          event.nidn, event.judul, event.sortBy);

      List<BKDRekrutmenData> bkdRekrutmenData = [];
      List<BKDPenilaianData> bkdPenilaianData = [];

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error in Profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(BKDSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(BKDSisterNotFoundState(null, null));
          } else if (failure.message == '') {
            emit(BKDSisterErrorState(nidn: event.nidn));
          }
        },
        (bkdSister) async {
          log.d('LoggedInBloc - logged in profile: $state');
          bkdRekrutmenData = bkdSister.bkdRekrutmenData.toList();
        },
      );
      await result1.fold(
        (failure) async {
          log.d('LoggedInBloc - error in Profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(BKDSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(BKDSisterNotFoundState(null, null));
          } else if (failure.message == '') {
            emit(BKDSisterErrorState(nidn: event.nidn));
          }
        },
        (bkdSister) async {
          log.d('LoggedInBloc - logged in profile: $state');
          bkdPenilaianData = bkdSister.bkdPenilaianData.toList();
        },
      );
      emit(BKDSisterLoadedState(
          judul: event.judul,
          sortBy: event.sortBy,
          nidn: event.nidn,
          bkdPenilaianData: bkdPenilaianData,
          bkdRekrutmenData: bkdRekrutmenData));
    } else {
      emit(BKDSisterNoInternetState(nidn: event.nidn));
    }
  }
}
