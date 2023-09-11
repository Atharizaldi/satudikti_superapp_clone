import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/prodiPTLN.dart';
import 'package:app/domain/usecases/ijazahln/getProdiPTLN.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_prodi_ptln_event.dart';
part 'detail_prodi_ptln_state.dart';

class DetailProdiPtlnBloc
    extends Bloc<DetailProdiPtlnEvent, DetailProdiPtlnState> {
  InternetCheck internetCheck;
  GetProdiPTLN getProdiPTLN;

  DetailProdiPtlnBloc({required this.internetCheck, required this.getProdiPTLN})
      : super(DetailProdiPtlnLoadingState()) {
    on<GetDetailProdiPtlnEvent>(_getDetailProdiPtlnEvent);
  }

  void _getDetailProdiPtlnEvent(
      GetDetailProdiPtlnEvent event, Emitter<DetailProdiPtlnState> emit) async {
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      final result = await getProdiPTLN.execute(event.idPt);
      await result.fold(
        (failure) async {
          emit(DetailProdiPtlnLoadingState());
        },
        (prodiPtln) async {
          emit(DetailProdiPtlnLoadedState(prodiPTLN: prodiPtln));
        },
      );
    } else {
      emit(DetailProdiPtlnLoadingState());
    }
  }
}
