import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/programTerdaftar.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_program_terdaftar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'program_terdaftar_event.dart';
part 'program_terdaftar_state.dart';

class ProgramTerdaftarBloc
    extends Bloc<ProgramTerdaftarEvent, ProgramTerdaftarState> {
  GetProgramTerdaftar getProgramTerdaftarUseCase;
  InternetCheck internetCheck;
  ProgramTerdaftarBloc({
    required this.getProgramTerdaftarUseCase,
    required this.internetCheck,
  }) : super(ProgramTerdaftarInitial()) {
    on<GetProgramTerdaftarEvent>(_onGetProgramTerdaftar);
  }

  void _onGetProgramTerdaftar(GetProgramTerdaftarEvent event,
      Emitter<ProgramTerdaftarState> emit) async {
    final isConnected = await internetCheck.hasConnection();

    if (isConnected) {
      final result =
          await getProgramTerdaftarUseCase.execute(event.nidn, event.tahun);
      result.fold((failure) {
        print("faile");
        emit(ProgramTerdaftarError());
      }, (programTerdaftar) {
        print(
            "success LIST PROGRAM ${programTerdaftar.data!.listProgramTerdaftar!}");
        emit(ProgramTerdaftarLoaded(
            list: programTerdaftar.data!.listProgramTerdaftar!));
      });
    } else {
      emit(ProgramTerdaftarNoInternet());
    }
  }
}
