import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListProdi.dart';
import 'package:app/domain/usecases/sivil/getSearchListProdi.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'bts_prodi_event.dart';
part 'bts_prodi_state.dart';

class BtsProdiBloc extends Bloc<BtsProdiEvent, BtsProdiState> {
  GetSearchListProdi getSearchListProdiUseCase;

  BtsProdiBloc({required this.getSearchListProdiUseCase})
      : super(BtsProdiNotFoundState()) {
    on<BtsSearchProdiEvent>(_searchProdi);
  }

  void _searchProdi(
      BtsSearchProdiEvent event, Emitter<BtsProdiState> emit) async {
    Logger().d("_searchProdi: ${event.query}");
    emit(BtsProdiLoadingState());

    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      final result =
          await getSearchListProdiUseCase.execute(event.idPt, event.query);

      await result.fold(
        (failure) async {
          emit(BtsProdiNotFoundState());
        },
        (getListProdi) async {
          List<String> list = getListProdi.data.prodi
              .map((prodi) => "${prodi.jenjangDidik.nama} ${prodi.nama}")
              .toList();
          emit(BtsProdiLoadedState(
              getListProdi: getListProdi, listProdiJenjangDidikName: list));
          Logger().d("prodi length : ${list.length}");
        },
      );
    } else {
      emit(BtsProdiNoInternetState());
    }
  }
}
