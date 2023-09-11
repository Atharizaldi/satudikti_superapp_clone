import 'package:app/common/baseUrl.dart';
import 'package:app/data/source/remote/model/IjazahLN/status/statusByEmail.dart';
import 'package:app/domain/usecases/ijazahln/getByEmail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'statuspengajuan_event.dart';
part 'statuspengajuan_state.dart';

class StatuspengajuanBloc
    extends Bloc<StatuspengajuanEvent, StatuspengajuanState> {
  GetByEmail getByEmail;
  StatuspengajuanBloc({required this.getByEmail})
      : super(StatuspengajuanLoading()) {
    on<FetchStatusPengajuan>(_getStatusPengajuan);
  }
  void _getStatusPengajuan(
      FetchStatusPengajuan event, Emitter<StatuspengajuanState> emit) async {
    final result = await getByEmail.execute(portDev, event.query);
    await result.fold(
      (failure) async {
        emit(StatusPengajuanLoadedFailed());
      },
      (listByEmail) async {
        if (state is FetchStatusPengajuanFailed) {
          emit(StatusPengajuanLoaded(listByEmail: listByEmail));
        } else {
          emit(StatusPengajuanLoaded(listByEmail: listByEmail));
        }
      },
    );
  }
}
