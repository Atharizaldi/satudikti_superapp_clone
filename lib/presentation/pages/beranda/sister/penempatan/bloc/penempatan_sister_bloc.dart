import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sister/penempatan_sister.dart';
import 'package:app/domain/usecases/sister/get_penempatan_sister.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'penempatan_sister_event.dart';
part 'penempatan_sister_state.dart';

class PenempatanSisterBloc
    extends Bloc<PenempatanSisterEvent, PenempatanSisterState> {
  GetPenempatanSister getPenempatanSister;
  Logger log;
  InternetCheck internetCheck;
  String nidn = '';
  PenempatanSisterBloc({
    required this.internetCheck,
    required this.getPenempatanSister,
    required this.log,
  }) : super(PenempatanSisterinInitial()) {
    on<GetPenempatanSisterEvent>(_getPenempatan);
  }

  void _getPenempatan(GetPenempatanSisterEvent event,
      Emitter<PenempatanSisterState> emit) async {
    print("================KEBLOC============");
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getPenempatanSister.execute(event.nidn);
      nidn = event.nidn;

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(PenempatanSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(PenempatanSisterNotFoundState(null));
          } else if (failure.message == '') {
            emit(PenempatanSisterErrorState(nidn: event.nidn));
            // emit(PenempatanSisterErrorState(nidn: event.nidn));
          }
        },
        (penempatanSister) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          emit(PenempatanSisterLoadedState(
            penempatanSister: penempatanSister,
            nidn: event.nidn,
          ));
        },
      );
    } else {
      emit(PenempatanSisterNoInternetState(nidn: event.nidn));
      // emit(PenempatanSisterErrorState(nidn: event.nidn));
    }
  }
}
