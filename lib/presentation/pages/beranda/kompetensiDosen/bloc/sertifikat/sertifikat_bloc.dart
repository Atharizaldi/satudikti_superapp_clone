import 'package:app/data/source/remote/model/kompetensiDosen/sertifikat.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_sertifikat.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sertifikat_event.dart';
part 'sertifikat_state.dart';

class SertifikatBloc extends Bloc<SertifikatEvent, SertifikatState> {
  GetSertifikat getSertifikatUseCase;
  SertifikatBloc({
    required this.getSertifikatUseCase,
  }) : super(SertifikatInitial()) {
    on<GetSertifikatEvent>(_onGetSertifikat);
  }

  void _onGetSertifikat(
      GetSertifikatEvent event, Emitter<SertifikatState> emit) async {
    final result = await getSertifikatUseCase.execute(event.id);

    result.fold((failure) {
      emit(SertifikatError());
    }, (response) {
      emit(SertifikatLoaded(sertifikat: response));
    });
  }
}
