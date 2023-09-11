import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/detail_ckm.dart';
import 'package:app/domain/usecases/kampusmerdeka/getDetailCKM.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'detail_cerita_km_event.dart';
part 'detail_cerita_km_state.dart';

class DetailCeritaKMBloc
    extends Bloc<DetailCeritaKMEvent, DetailCeritaKMState> {
  GetDetailCKM getDetailCKM;
  Logger log;
  InternetCheck internetCheck;
  String id = '';

  DetailCeritaKMBloc({
    required this.getDetailCKM,
    required this.log,
    required this.internetCheck,
  }) : super(DetailCeritaKMinInitial()) {
    on<GetDetailCeritaKMEvent>(_getDetailCeritaKM);
  }

  void _getDetailCeritaKM(
      GetDetailCeritaKMEvent event, Emitter<DetailCeritaKMState> emit) async {
    print('========== GET DETAIL CKM HAS SUMMONED ==========');
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      emit(DetailCeritaKMinLoading());
      final result = await getDetailCKM.execute(event.id);

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error in profile: $state');
          log.d('loggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(DetailCeritaKMErrorState());
          }
        },
        (detailCeritaKM) async {
          log.d('LoggedInBloc - logged in to profile: $state');
          emit(DetailCeritaKMLoadedState(
              dataDetailCerita: detailCeritaKM.dataDetailCerita));
        },
      );
    } else {
      emit(DetailCeritaKMNoInternetState(id: event.id ));
    }
    print('========== GET DETAIL CKM HAS SUMMONED ==========');
  }
}
