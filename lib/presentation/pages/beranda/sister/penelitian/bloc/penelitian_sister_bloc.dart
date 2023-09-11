import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sister/penelitian_sister.dart';
import 'package:app/domain/usecases/sister/get_penelitian_sister.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'penelitian_sister_event.dart';
part 'penelitian_sister_state.dart';

class PenelitianSisterBloc
    extends Bloc<PenelitianSisterEvent, PenelitianSisterState> {
  GetPenelitianSister getPenelitianSister;
  Logger log;
  InternetCheck internetCheck;
  String nidn = '';

  PenelitianSisterBloc({
    required this.getPenelitianSister,
    required this.internetCheck,
    required this.log,
  }) : super(PenelitianSisterinInitial()) {
    on<GetPenelitianSisterEvent>(_getPenelitian);
  }

  void _getPenelitian(GetPenelitianSisterEvent event,
      Emitter<PenelitianSisterState> emit) async {
    print("================KEBLOC============");
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getPenelitianSister.execute(event.nidn);
      nidn = event.nidn;

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(PenelitianSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(PenelitianSisterNotFoundState(null));
          } else if (failure.message == '') {
            emit(PenelitianSisterErrorState(nidn: event.nidn));
          }
        },
        (penelitianSister) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          // pendidikanINFormal = pendidikanSister.pendidikanFormal.toList();
          // pengajaran = pendidikanSister.pengajaran.toList();

          emit(PenelitianSisterLoadedState(
            penelitianData: penelitianSister.penelitianData,
            publikasi: penelitianSister.publikasi,
            nidn: event.nidn,
          ));
        },
      );
    } else {
      // emit(SisterLoggedInNoInternetState(nidn: event.nidn));
      emit(PenelitianSisterNoInternetState(nidn: event.nidn));
    }
  }
}
