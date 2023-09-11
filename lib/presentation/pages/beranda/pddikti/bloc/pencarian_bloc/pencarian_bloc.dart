import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/elasticSearch.dart';
import 'package:app/domain/usecases/pddikti/getElasticSearch.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'pencarian_event.dart';
part 'pencarian_state.dart';

class PencarianBloc extends Bloc<PencarianEvent, PencarianState> {
  GetElasticSearch getElasticSearchUseCase;
  Logger log;

  PencarianBloc({required this.getElasticSearchUseCase, required this.log})
      : super(PencarianInitialState()) {
    on<LoadPencarianEvent>(_loadEvent);
  }

  void _loadEvent(
      LoadPencarianEvent event, Emitter<PencarianState> emit) async {
    emit(PencarianLoadingState());
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final resultSearch = await getElasticSearchUseCase.execute(event.keyword);
      await resultSearch.fold(
        (failure) async {
          log.i("LoadPencarianEvent failure: ${failure}");
          emit(PencarianNotFoundState());
        },
        (response) async {
          List<Pt> pt = response.data?.dashboard?.pt ?? [];
          List<Prodi> prodi = response.data?.dashboard?.prodi ?? [];
          List<Dosen> dosen = response.data?.dashboard?.dosen ?? [];
          List<Mahasiswa> mahasiswa = response.data?.dashboard?.mahasiswa ?? [];
          log.i(
              "LoadPencarianEvent success, pt(${pt.length}) prodi(${prodi.length}) dosen(${dosen.length}) mahasiswa(${mahasiswa.length})");
          emit(PencarianLoadedState(
            pt: pt,
            prodi: prodi,
            dosen: dosen,
            mahasiswa: mahasiswa,
          ));
        },
      );
    } else {
      emit(PencarianNoInternetState());
    }
  }
}
