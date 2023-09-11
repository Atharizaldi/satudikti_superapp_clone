import 'package:app/data/source/remote/model/kompetensiDosen/unduhan.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_unduhan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'unduhan_event.dart';
part 'unduhan_state.dart';

class UnduhanBloc extends Bloc<UnduhanEvent, UnduhanState> {
  GetUnduhan getUnduhanUseCase;

  UnduhanBloc({
    required this.getUnduhanUseCase,
  }) : super(UnduhanInitial()) {
    on<GetUnduhanEvent>(_onGetUnduhanEvent);
  }

  void _onGetUnduhanEvent(
      GetUnduhanEvent event, Emitter<UnduhanState> emit) async {
    final result = await getUnduhanUseCase.execute(event.id);

    result.fold((failure) {
      emit(UnduhanError());
    }, (response) {
      emit(UnduhanLoaded(unduhan: response));
    });
  }
}
