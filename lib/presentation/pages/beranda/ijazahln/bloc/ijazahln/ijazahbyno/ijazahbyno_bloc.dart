import 'package:app/common/baseUrl.dart';
import 'package:app/data/source/remote/model/IjazahLN/status/statusByNoRegis.dart';
import 'package:app/domain/usecases/ijazahln/getByNoReg.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ijazahbyno_event.dart';
part 'ijazahbyno_state.dart';

class IjazahbynoBloc extends Bloc<IjazahbynoEvent, IjazahbynoState> {
  GetByNoReg getByNoReg;
  IjazahbynoBloc({required this.getByNoReg}) : super(IjazahbynoLoading()) {
    on<FetchIjazahByNo>(_getIjazahByNo);
  }
  void _getIjazahByNo(
      FetchIjazahByNo event, Emitter<IjazahbynoState> emit) async {
    final result = await getByNoReg.execute(portDev, event.query);
    await result.fold(
      (failure) async {
        emit(IjazahbynoFailed());
      },
      (listByReg) async {
        if (state is IjazahbynoLoading) {
          emit(IjazahbynoLoaded(listByReg: listByReg));
        } else {
          emit(IjazahbynoLoaded(listByReg: listByReg));
        }
      },
    );
  }
}
