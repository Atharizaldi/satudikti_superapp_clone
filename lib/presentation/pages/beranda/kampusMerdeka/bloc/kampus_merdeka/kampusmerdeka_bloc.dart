import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/MBKMList.dart'
    as MBKMList;
import 'package:app/domain/usecases/kampusmerdeka/getMbkm.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kampusmerdeka_event.dart';
part 'kampusmerdeka_state.dart';

class KampusmerdekaBloc extends Bloc<KampusmerdekaEvent, KampusmerdekaState> {
  GetMBKM getMBKM;
  InternetCheck internetCheck;

  KampusmerdekaBloc({required this.getMBKM, required this.internetCheck})
      : super(KampusmerdekaLoadingState()) {
    on<GetKMListEvent>(_running);
  }

  void _running(GetKMListEvent event, Emitter<KampusmerdekaState> emit) async {
    List<MBKMList.Data> running = [];
    List<MBKMList.Data> notRunning = [];

    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      final result = await getMBKM.execute();
      await result.fold(
        (failure) async {
          if (failure.message == 'error500') {
            emit(KampusmerdekaErrorState());
          } else {
            emit(KampusmerdekaNoInternetState());
          }
        },
        (mbkmList) async {
          running = mbkmList.data.where((data) => data.isRunning == 1).toList();
          notRunning =
              mbkmList.data.where((data) => data.isRunning == 0).toList();
          emit(KampusmerdekaLoadedState(
              running: running, willBeRunning: notRunning));
        },
      );
    } else {
      emit(KampusmerdekaNoInternetState());
    }
  }
}
