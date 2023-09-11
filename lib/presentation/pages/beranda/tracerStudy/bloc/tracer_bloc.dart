import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/config.dart';
import 'package:app/domain/usecases/config/getConfig.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'tracer_event.dart';
part 'tracer_state.dart';

class TracerBloc extends Bloc<TracerEvent, TracerState> {
  GetConfig getConfig;

  TracerBloc({required this.getConfig}) : super(TracerConfigInitial()) {
    on<TracerConfigEvent>(_getConfig);
  }

  void _getConfig(TracerConfigEvent event, Emitter<TracerState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      Logger().i('MODULE ID: ${event.moduleId}');
      emit(TracerConfigLoadingState());
      final getConfigTracer = await getConfig.execute(event.moduleId);
      getConfigTracer.fold((failure) async {
        emit(TracerConfigErrorState());
      }, (r) async {
        emit(TracerConfigLoadedState(config: r));
      });
    }
  }
}
