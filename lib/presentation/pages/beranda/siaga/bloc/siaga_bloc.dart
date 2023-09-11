import 'package:app/data/source/remote/model/siaga/searchTracking.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'siaga_event.dart';
part 'siaga_state.dart';

class SiagaBloc extends Bloc<SiagaEvent, SiagaState> {
  Logger log;

  SiagaBloc({required this.log}) : super(SiagaInitialState()) {
    on<UpdateSiagaEvent>(_onUpdatePT);
  }

  void _onUpdatePT(UpdateSiagaEvent event, Emitter<SiagaState> emit) {
    emit(SiagaInitialState(pt: event.pt));
  }
}
