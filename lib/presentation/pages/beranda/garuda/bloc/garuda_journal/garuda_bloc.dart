import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/domain/usecases/garuda/getListJournal.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'garuda_event.dart';
part 'garuda_state.dart';

class GarudaBloc extends Bloc<GarudaEvent, GarudaState> {
  GetListJournal getListJournal;
  InternetCheck internetCheck;
  GarudaBloc({required this.getListJournal, required this.internetCheck})
      : super(GarudaInitialState()) {
    on<SearchGarudaJournalEvent>(_searchGarudaJournal);
    on<SearchGarudaJournalRefreshEvent>(_refreshJournal);
  }
  void _searchGarudaJournal(
      SearchGarudaJournalEvent event, Emitter<GarudaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        if (state is GarudaLoadedState) {
          GarudaLoadedState garudaLoadedState = state as GarudaLoadedState;
          if (garudaLoadedState.hasReachedMax) {
          } else {
            int newPage = garudaLoadedState.newPage + 1;
            final result = await getListJournal.execute(newPage);
            await result.fold((failure) async {
              emit(GarudaServerBermasalahState());
            }, (listGarudaJournal) async {
              if (listGarudaJournal.data!.resultGaruda.journalGaruda.isEmpty) {
                emit(GarudaTidakAdaDataState());
              } else {
                bool hasReached = listGarudaJournal
                        .data!.resultGaruda.journalGaruda.isEmpty ||
                    listGarudaJournal.data!.resultGaruda.journalGaruda.length <
                        defaultLimit;
                emit(GarudaLoadedState(
                    hasReachedMax: hasReached,
                    newPage: newPage,
                    journalGaruda: garudaLoadedState.journalGaruda +
                        listGarudaJournal.data!.resultGaruda.journalGaruda,
                    dataGaruda: listGarudaJournal));
              }
            });
          }
        } else {
          emit(GarudaLoadingState());
          final result = await getListJournal.execute(1);
          await result.fold((failure) async {
            emit(GarudaServerBermasalahState());
          }, (listGarudaJournal) async {
            if (listGarudaJournal.data!.resultGaruda.journalGaruda.isEmpty) {
              emit(GarudaTidakAdaDataState());
            } else {
              bool hasReached = listGarudaJournal
                      .data!.resultGaruda.journalGaruda.isEmpty ||
                  listGarudaJournal.data!.resultGaruda.journalGaruda.length <
                      defaultLimit;
              emit(GarudaLoadedState(
                  hasReachedMax: hasReached,
                  newPage: 1,
                  journalGaruda:
                      listGarudaJournal.data!.resultGaruda.journalGaruda,
                  dataGaruda: listGarudaJournal));
            }
          });
        }
      } else {
        emit(GarudaNoInternetState());
      }
    } catch (e) {
      emit(GarudaNoInternetState());
    }
  }

  void _refreshJournal(
      SearchGarudaJournalRefreshEvent event, Emitter<GarudaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        emit(GarudaLoadingState());
        final result = await getListJournal.execute(1);
        await result.fold((failure) async {
          emit(GarudaServerBermasalahState());
        }, (listGarudaJournal) async {
          if (listGarudaJournal.data!.resultGaruda.journalGaruda.isEmpty) {
            emit(GarudaTidakAdaDataState());
          } else {
            bool hasReached =
                listGarudaJournal.data!.resultGaruda.journalGaruda.isEmpty ||
                    listGarudaJournal.data!.resultGaruda.journalGaruda.length <
                        defaultLimit;
            emit(GarudaLoadedState(
                hasReachedMax: hasReached,
                newPage: 1,
                journalGaruda:
                    listGarudaJournal.data!.resultGaruda.journalGaruda,
                dataGaruda: listGarudaJournal));
          }
        });
      } else {
        emit(GarudaNoInternetState());
      }
    } catch (e) {
      emit(GarudaNoInternetState());
    }
  }
}
