import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/data/source/remote/model/garuda/garudaPaper.dart';
import 'package:app/domain/usecases/garuda/searchGarudaJournal.dart';
import 'package:app/domain/usecases/garuda/searchGarudaPaper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'garuda_umum_search_event.dart';
part 'garuda_umum_search_state.dart';

class GarudaUmumSearchBloc
    extends Bloc<GarudaUmumSearchEvent, GarudaUmumSearchState> {
  SearchGarudaJournal searchGarudaJournal;
  SearchGarudaPaper searchGarudaPaper;
  InternetCheck internetCheck;
  GarudaUmumSearchBloc(
      {required this.searchGarudaJournal,
      required this.searchGarudaPaper,
      required this.internetCheck})
      : super(GarudaUmumSearchInitial()) {
    on<GarudaUmumSearchMainEvent>(_garudaUmumSearch);
  }
  void _garudaUmumSearch(GarudaUmumSearchMainEvent event,
      Emitter<GarudaUmumSearchState> emit) async {
    GarudaPaper? garudaPaper = GarudaPaper(message: '');
    Garuda? garudaJournal = Garuda(message: '');
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        emit(GarudaUmumSearchLoading());
        final resultPaper =
            await searchGarudaPaper.execute(event.keyword.toString(), 1);
        final resultJurnal =
            await searchGarudaJournal.execute(event.keyword.toString(), 1);
        await resultPaper.fold((l) async {
          emit(GarudaUmumSearchFailed());
          garudaPaper = null;
        }, (r) async {
          garudaPaper = r;
        });
        await resultJurnal.fold((l) async {
          emit(GarudaUmumSearchFailed());
          garudaJournal = null;
        }, (r) async {
          garudaJournal = r;
        });

        if (garudaPaper != null && garudaJournal != null) {
          emit(GarudaUmumSearchLoaded(
              garudaPaperObject: garudaPaper,
              garudaPaper: garudaPaper!.data!.listPaperGaruda,
              dataGaruda: garudaJournal,
              journalGaruda: garudaJournal!.data!.resultGaruda.journalGaruda));
        }
      } else {
        emit(GarudaUmumSearchNoInternet());
      }
    } catch (e) {
      emit(GarudaUmumSearchNoInternet());
    }
  }
}
