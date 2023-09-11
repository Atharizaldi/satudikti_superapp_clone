import 'package:app/common/baseUrl.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ststusSK.dart';
import 'package:app/domain/usecases/ijazahln/getPostVerif.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verifikasisk_event.dart';
part 'verifikasisk_state.dart';

class VerifikasiskBloc extends Bloc<VerifikasiskEvent, VerifikasiskState> {
  GetPostVerif getPostVerif;
  InternetCheck internetCheck;
  VerifikasiskBloc({required this.getPostVerif, required this.internetCheck})
      : super(VerifikasiskLoading()) {
    on<FetchVerifikasiSk>(_getVerifikasiSk);
  }
  void _getVerifikasiSk(
      FetchVerifikasiSk event, Emitter<VerifikasiskState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      final result = await getPostVerif.execute(
          portDev, event.idNegara, event.idPt, event.nomorSK);
      await result.fold(
        (failure) async {
          emit(VerifikasiSkFailed());
        },
        (listVerif) async {
          emit(VerifikasiskLoaded(listVerif: listVerif));
        },
      );
    } else {
      emit(VerifikasiSkFailed());
    }
  }
}
