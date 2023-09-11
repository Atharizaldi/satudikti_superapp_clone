import 'package:app/common/failure.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/tawaranProgram.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_list_tawaran_program.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_tawaran_program_event.dart';
part 'list_tawaran_program_state.dart';

class ListTawaranProgramBloc
    extends Bloc<ListTawaranProgramEvent, ListTawaranProgramState> {
  GetListTawaranProgram getListTawaranProgram;
  InternetCheck internetCheck;
  ListTawaranProgramBloc(
      {required this.getListTawaranProgram, required this.internetCheck})
      : super(ListTawaranProgramInitial()) {
    on<GetListTawaranProgramEvent>(_onGetListTawaranProgram);
  }

  void _onGetListTawaranProgram(GetListTawaranProgramEvent event,
      Emitter<ListTawaranProgramState> emit) async {
    final isConnected = await internetCheck.hasConnection();

    if (isConnected) {
      final result = await getListTawaranProgram.execute();

      result.fold((failure) {
        if (failure is NotFoundFailure) {
          emit(ListTawaranProgramLoaded(list: []));
        } else {
          emit(ListTawaranProgramError());
        }
      }, (response) {
        emit(
            ListTawaranProgramLoaded(list: response.data!.listTawaranProgram!));
      });
    } else {
      emit(ListTawaranProgramNoInternet());
    }
  }
}
