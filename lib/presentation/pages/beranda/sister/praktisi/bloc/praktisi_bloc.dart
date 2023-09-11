import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sister/praktisi_sister.dart';
import 'package:app/domain/usecases/sister/get_praktisi_sister.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'praktisi_event.dart';

part 'praktisi_state.dart';

class PraktisiSisterBloc
    extends Bloc<PraktisiSisterEvent, PraktisiSisterState> {
  GetPraktisiSister getPraktisiSister;
  Logger log;
  InternetCheck internetCheck;
  String nidn = '';

  PraktisiSisterBloc(
      {required this.internetCheck,
      required this.getPraktisiSister,
      required this.log})
      : super(PraktisiSisterInitial()) {
    on<GetPraktisiSisterEvent>(_getPraktisi);
  }

  void _getPraktisi(
      GetPraktisiSisterEvent event, Emitter<PraktisiSisterState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getPraktisiSister.execute(event.nidn);
      nidn = event.nidn;

      await result.fold((failure) async {
        log.d('LoggedInBloc - error di profile: $state');
        log.d('LoggedInBloc - failure msg: ${failure.message}');
        if (failure.message == 'error500') {
          emit(PraktisiSisterErrorState(nidn: event.nidn));
        } else if (failure.message == 'error404') {
          emit(PraktisiSisterNotFoundState(null));
        } else if (failure.message == '') {
          emit(PraktisiSisterErrorState(nidn: event.nidn));
        }
      }, (praktisiSisterTerserah) async {
        log.d('LoggedInBloc - masuk ke profil: $state');
        emit(PraktisiSisterLoadedState(
            praktisiSister: praktisiSisterTerserah.praktisiData,
            nidn: event.nidn));
      });
    } else {
      emit(PraktisiSisterNoInternetState(nidn: event.nidn));
    }
  }
}
