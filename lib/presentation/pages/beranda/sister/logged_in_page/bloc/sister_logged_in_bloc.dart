import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/local/sharedpreferences.dart';
import 'package:app/data/source/remote/model/sister/profile_sister_detail.dart';
import 'package:app/domain/usecases/sister/get_profile_detail_sister.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'sister_logged_in_event.dart';
part 'sister_logged_in_state.dart';

class SisterLoggedinBloc
    extends Bloc<SisterLoggedinEvent, SisterLoggedinState> {
  GetProfileDetailSister getProfileDetailSister;
  InternetCheck internetCheck;
  Logger log;
  SisterLoggedinBloc({
    required this.getProfileDetailSister,
    required this.internetCheck,
    required this.log,
  }) : super(SisterLoggedinInitial()) {
    on<SisterGetProfileEvent>(_getSisterProfileInfos);
  }

  void _getSisterProfileInfos(
      SisterGetProfileEvent event, Emitter<SisterLoggedinState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getProfileDetailSister.execute(event.nidn);
      List<String> dataDosen = Prefs.getDataDosen() ?? [''];
      // late String avatarPhoto = dataDosen[1];

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(SisterLoggedInErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(SisterLoggedInNotFoundState(null));
          } else if (failure.message == '') {
            emit(SisterLoggedInErrorState(nidn: event.nidn));
            // emit(SisterLoggedInNoInternetState(nidn: event.nidn));
          }
        },
        (profileDetail) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          log.d('mau load avatar?: $dataDosen');
          emit(SisterLoggedInLoadedState(
              profileDetail: profileDetail,
              nidn: event.nidn,
              dataDosen: dataDosen));
        },
      );
    } else {
      // emit(SisterLoggedInNoInternetState(nidn: event.nidn));
      emit(SisterLoggedInErrorState(nidn: event.nidn));
    }
  }
}
