import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/garuda/statistikGaruda.dart';
import 'package:app/domain/usecases/garuda/getStatistikGaruda.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'statistik_garuda_event.dart';
part 'statistik_garuda_state.dart';

class StatistikGarudaBloc
    extends Bloc<StatistikGarudaEvent, StatistikGarudaState> {
  GetListStatistikGaruda listStatistikGaruda;
  InternetCheck internetCheck;
  StatistikGarudaBloc(
      {required this.listStatistikGaruda, required this.internetCheck})
      : super(StatistikGarudaInitial()) {
    on<StatistikGarudaMainEvent>(_getStatistikGaruda);
  }
  void _getStatistikGaruda(StatistikGarudaMainEvent event,
      Emitter<StatistikGarudaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      Logger().i('statistik garudaaaaaaaaaaaaaaa');
      try {
        emit(StatistikGarudaLoading());
        final result = await listStatistikGaruda.execute();
        result.fold((left) async {
          emit(StatistikGarudaFailed());
        }, (right) async {
          emit(StatistikGarudaLoaded(modelStatistikGaruda: right));
        });
      } catch (e) {
        print("err $e");
        emit(StatistikGarudaFailed());
      }
    } else {
      emit(StatistikGarudaFailed());
    }
  }
}
