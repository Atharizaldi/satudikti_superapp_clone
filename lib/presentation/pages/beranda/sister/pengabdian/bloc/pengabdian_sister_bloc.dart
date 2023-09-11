import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sister/pengabdian_sister.dart';
import 'package:app/domain/usecases/sister/get_pengabdian_sister.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'pengabdian_sister_event.dart';
part 'pengabdian_sister_state.dart';

class PengabdianSisterBloc
    extends Bloc<PengabdianSisterEvent, PengabdianSisterState> {
  GetPengabdianSister getPengabdianSister;
  Logger log;
  InternetCheck internetCheck;
  String nidn = '';

  PengabdianSisterBloc({
    required this.getPengabdianSister,
    required this.internetCheck,
    required this.log,
  }) : super(PengabdianSisterinInitial()) {
    on<GetPengabdianSisterEvent>(_getPengabdian);
  }

  void _getPengabdian(GetPengabdianSisterEvent event,
      Emitter<PengabdianSisterState> emit) async {
    print("================KEBLOC============");
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getPengabdianSister.execute(event.nidn);

      nidn = event.nidn;

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(PengabdianSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(PengabdianSisterNotFoundState(null));
          } else if (failure.message == '') {
            emit(PengabdianSisterErrorState(nidn: event.nidn));
            // emit(SisterLoggedInNoInternetState(nidn: event.nidn));
          }
        },
        (pengabdianSister) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          // pendidikanINFormal = pendidikanSister.pendidikanFormal.toList();
          // pengajaran = pendidikanSister.pengajaran.toList();

          emit(PengabdianSisterLoadedState(
            pengabdianData: pengabdianSister.pengabdianData,
            nidn: event.nidn,
          ));
        },
      );
    } else {
      // emit(SisterLoggedInNoInternetState(nidn: event.nidn));
      emit(PengabdianSisterNoInternetState(nidn: event.nidn));
    }
  }
}
