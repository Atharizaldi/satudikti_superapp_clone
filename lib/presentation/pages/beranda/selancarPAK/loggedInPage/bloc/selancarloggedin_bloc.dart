import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/selancar/profile_PAK_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:app/domain/usecases/selancar/get_profile_detail_selancar.dart';
import 'package:app/domain/usecases/selancar/get_usulan_detail.dart';
import 'package:app/domain/usecases/selancar/get_usulan_list.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'selancarloggedin_event.dart';
part 'selancarloggedin_state.dart';

class SelancarloggedinBloc
    extends Bloc<SelancarloggedinEvent, SelancarloggedinState> {
  GetProfileDetailSelancar getProfileDetailSelancar;
  GetUsulanList getUsulanList;
  GetUsulanDetail getUsulanDetail;
  InternetCheck internetCheck;
  Logger log;
  SelancarloggedinBloc({
    required this.getProfileDetailSelancar,
    required this.getUsulanList,
    required this.getUsulanDetail,
    required this.internetCheck,
    required this.log,
  }) : super(SelancarloggedinInitial()) {
    on<SelancarGetProfileEvent>(_getSelancarProfileInfos);
    on<SelancarGetUsulanListEvent>(_getSelancarUsulanList);
    on<SelancarGetUsulanDetailEvent>(_getSelancarUsulanDetail);
  }

  void _getSelancarProfileInfos(SelancarGetProfileEvent event,
      Emitter<SelancarloggedinState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getProfileDetailSelancar.execute(event.nidn);

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(SelancarLoggedInErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(SelancarLoggedInNotFoundState(null));
          } else if (failure.message == '') {
            emit(SelancarLoggedInErrorState(nidn: event.nidn));
            // emit(SelancarLoggedInNoInternetState(nidn: event.nidn));
          }
        },
        (profileDetail) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          emit(SelancarLoggedInLoadedState(
            profileDetail: profileDetail,
            usulanList: [],
            usulanDetail: UsulanDetail(
                message: '', progressPercentage: 0, detailUsulan: []),
            nidn: event.nidn,
          ));
          add(SelancarGetUsulanListEvent(nidn: event.nidn));
        },
      );
    } else {
      // emit(SelancarLoggedInNoInternetState(nidn: event.nidn));
      emit(SelancarLoggedInErrorState(nidn: event.nidn));
    }
  }

  void _getSelancarUsulanList(SelancarGetUsulanListEvent event,
      Emitter<SelancarloggedinState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getUsulanList.execute(event.nidn);

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di usulan: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(SelancarLoggedInErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            SelancarLoggedInLoadedState loadedState =
                state as SelancarLoggedInLoadedState;
            emit(SelancarLoggedInNotFoundState(loadedState.profileDetail));
          } else {
            emit(SelancarLoggedInNoInternetState(nidn: event.nidn));
          }
        },
        (usulanList) async {
          log.d('LoggedInBloc - masuk ke usulan: $state');
          if (state is SelancarLoggedInLoadedState) {
            SelancarLoggedInLoadedState loadedState =
                state as SelancarLoggedInLoadedState;
            emit(SelancarLoggedInLoadedState(
                profileDetail: loadedState.profileDetail,
                usulanList: usulanList.usulan,
                usulanDetail: UsulanDetail(
                    message: '', progressPercentage: 0, detailUsulan: []),
                nidn: event.nidn));
            add(SelancarGetUsulanDetailEvent(nidn: event.nidn));
          } else {
            emit(SelancarLoggedInErrorState(nidn: event.nidn));
          }
        },
      );
    } else {
      emit(SelancarLoggedInNoInternetState(nidn: event.nidn));
    }
  }

  void _getSelancarUsulanDetail(SelancarGetUsulanDetailEvent event,
      Emitter<SelancarloggedinState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      SelancarLoggedInLoadedState loadedState =
          state as SelancarLoggedInLoadedState;
      final result = await getUsulanDetail.execute(
        event.nidn,
        loadedState.usulanList.last.id,
      );
      // int i = 0;
      // List<UsulanDetail> usulanDetailList = [];
      // do {
      //   final result = await getUsulanDetail.execute(
      //       event.nidn, loadedState.usulanList[i].id);

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di usulandetail: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(SelancarLoggedInErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            SelancarLoggedInLoadedState loadedState =
                state as SelancarLoggedInLoadedState;
            emit(SelancarLoggedInNotFoundState(loadedState.profileDetail));
          } else {
            emit(SelancarLoggedInNoInternetState(nidn: event.nidn));
          }
        },
        (usulanDetail) async {
          log.d('LoggedInBloc - masuk ke usulandetail: $state');
          if (state is SelancarLoggedInLoadedState) {
            emit(SelancarLoggedInLoadedState(
              profileDetail: loadedState.profileDetail,
              usulanList: loadedState.usulanList,
              usulanDetail: usulanDetail,
              nidn: event.nidn,
            ));
          } else {
            emit(SelancarLoggedInErrorState(nidn: event.nidn));
          }
        },
      );
    } else {
      emit(SelancarLoggedInNoInternetState(nidn: event.nidn));
    }
  }
}
