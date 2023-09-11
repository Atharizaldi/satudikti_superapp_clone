import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/domain/usecases/garuda/searchGarudaJournal.dart';
import 'package:app/domain/usecases/garuda/searchGarudaJournalBySubject.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'garuda_searching_journal_event.dart';
part 'garuda_searching_journal_state.dart';

class GarudaSearchingJournalBloc
    extends Bloc<GarudaSearchingJournalEvent, GarudaSearchingJournalState> {
  String keywordJournalList = "";
  String keywordId = "";
  String keywordJournalSearching = "";
  SearchGarudaJournal searchGarudaJournal;
  SearchGarudaJournalBySubject searchGarudaJournalBySubject;
  InternetCheck internetCheck;
  GarudaSearchingJournalBloc(
      {required this.searchGarudaJournal,
      required this.searchGarudaJournalBySubject,
      required this.internetCheck})
      : super(GarudaSearchingJournalInitial()) {
    on<GarudaSearchingEvent>(_garudaSearchingListJournal);
    on<GarudaSearchingBySubjectEvent>(_garudaSearchingJournalBySubject);
  }
  void _garudaSearchingListJournal(GarudaSearchingEvent event,
      Emitter<GarudaSearchingJournalState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        if (state is GarudaSearchingJournalLoaded) {
          GarudaSearchingJournalLoaded garudaSearchingJournalLoaded =
              state as GarudaSearchingJournalLoaded;
          if (garudaSearchingJournalLoaded.hasReachedMax &&
              event.keyword != keywordJournalList &&
              keywordId == "") {
            emit(GarudaSearchingJournalLoading());
            final result =
                await searchGarudaJournal.execute(event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              if (searchGarudaJournal
                  .data!.resultGaruda.journalGaruda.isEmpty) {
                emit(GarudaSearchingJournalNotFound());
              } else {
                bool hasReached = searchGarudaJournal
                        .data!.resultGaruda.journalGaruda.isEmpty ||
                    searchGarudaJournal
                            .data!.resultGaruda.journalGaruda.length <
                        defaultLimit;
                emit(GarudaSearchingJournalLoaded(
                    dataGaruda: searchGarudaJournal,
                    hasReachedMax: hasReached,
                    newPage: 1,
                    journalGaruda:
                        searchGarudaJournal.data!.resultGaruda.journalGaruda));
              }
            });
            keywordJournalList = event.keyword.toString();
          } else if (garudaSearchingJournalLoaded.hasReachedMax == false &&
              event.keyword != keywordJournalList &&
              keywordId == "") {
            emit(GarudaSearchingJournalLoading());
            final result =
                await searchGarudaJournal.execute(event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              if (searchGarudaJournal
                  .data!.resultGaruda.journalGaruda.isEmpty) {
                emit(GarudaSearchingJournalNotFound());
              } else {
                bool hasReached = searchGarudaJournal
                        .data!.resultGaruda.journalGaruda.isEmpty ||
                    searchGarudaJournal
                            .data!.resultGaruda.journalGaruda.length <
                        defaultLimit;
                emit(GarudaSearchingJournalLoaded(
                    dataGaruda: searchGarudaJournal,
                    hasReachedMax: hasReached,
                    newPage: 1,
                    journalGaruda:
                        searchGarudaJournal.data!.resultGaruda.journalGaruda));
              }
            });
            keywordJournalList = event.keyword.toString();
          } else if (garudaSearchingJournalLoaded.hasReachedMax &&
              keywordId != "") {
            emit(GarudaSearchingJournalLoading());
            final result =
                await searchGarudaJournal.execute(event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              if (searchGarudaJournal
                  .data!.resultGaruda.journalGaruda.isEmpty) {
                emit(GarudaSearchingJournalNotFound());
              } else {
                bool hasReached = searchGarudaJournal
                        .data!.resultGaruda.journalGaruda.isEmpty ||
                    searchGarudaJournal
                            .data!.resultGaruda.journalGaruda.length <
                        defaultLimit;
                emit(GarudaSearchingJournalLoaded(
                    dataGaruda: searchGarudaJournal,
                    hasReachedMax: hasReached,
                    newPage: 1,
                    journalGaruda:
                        searchGarudaJournal.data!.resultGaruda.journalGaruda));
                keywordId = "";
              }
            });
            keywordJournalList = event.keyword.toString();
          } else if (garudaSearchingJournalLoaded.hasReachedMax == false &&
              keywordId != "") {
            emit(GarudaSearchingJournalLoading());
            final result =
                await searchGarudaJournal.execute(event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              if (searchGarudaJournal
                  .data!.resultGaruda.journalGaruda.isEmpty) {
                emit(GarudaSearchingJournalNotFound());
              } else {
                bool hasReached = searchGarudaJournal
                        .data!.resultGaruda.journalGaruda.isEmpty ||
                    searchGarudaJournal
                            .data!.resultGaruda.journalGaruda.length <
                        defaultLimit;
                emit(GarudaSearchingJournalLoaded(
                    dataGaruda: searchGarudaJournal,
                    hasReachedMax: hasReached,
                    newPage: 1,
                    journalGaruda:
                        searchGarudaJournal.data!.resultGaruda.journalGaruda));
                keywordId = "";
              }
            });
            keywordJournalList = event.keyword.toString();
          } else if (garudaSearchingJournalLoaded.hasReachedMax &&
              event.keyword == keywordJournalList) {
            print('MAX !! list');
          } else {
            int newPage = garudaSearchingJournalLoaded.newPage + 1;
            final result = await searchGarudaJournal.execute(
                event.keyword.toString(), newPage);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              bool hasReached = searchGarudaJournal
                      .data!.resultGaruda.journalGaruda.isEmpty ||
                  searchGarudaJournal.data!.resultGaruda.journalGaruda.length <
                      defaultLimit;
              emit(GarudaSearchingJournalLoaded(
                  dataGaruda: searchGarudaJournal,
                  hasReachedMax: hasReached,
                  newPage: newPage,
                  journalGaruda: garudaSearchingJournalLoaded.journalGaruda +
                      searchGarudaJournal.data!.resultGaruda.journalGaruda));
            });
          }
        } else {
          emit(GarudaSearchingJournalLoading());
          final result =
              await searchGarudaJournal.execute(event.keyword.toString(), 1);
          await result.fold((failure) async {
            emit(GarudaSearchingJournalNotFound());
          }, (searchGarudaJournal) async {
            if (searchGarudaJournal.data!.resultGaruda.journalGaruda.isEmpty) {
              emit(GarudaSearchingJournalNotFound());
            } else {
              bool hasReached = searchGarudaJournal
                      .data!.resultGaruda.journalGaruda.isEmpty ||
                  searchGarudaJournal.data!.resultGaruda.journalGaruda.length <
                      defaultLimit;
              emit(GarudaSearchingJournalLoaded(
                  dataGaruda: searchGarudaJournal,
                  hasReachedMax: hasReached,
                  newPage: 1,
                  journalGaruda:
                      searchGarudaJournal.data!.resultGaruda.journalGaruda));
            }
          });
          keywordJournalList = event.keyword.toString();
        }
      } else {
        emit(GarudaSearchingJournalNoInternet());
      }
    } catch (e) {
      emit(GarudaSearchingJournalNoInternet());
    }
  }

  void _garudaSearchingJournalBySubject(GarudaSearchingBySubjectEvent event,
      Emitter<GarudaSearchingJournalState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        if (state is GarudaSearchingJournalLoaded) {
          GarudaSearchingJournalLoaded garudaSearchingJournalLoaded =
              state as GarudaSearchingJournalLoaded;
          if (garudaSearchingJournalLoaded.hasReachedMax &&
              event.keyword != keywordJournalSearching) {
            emit(GarudaSearchingJournalLoading());
            final result = await searchGarudaJournalBySubject.execute(
                event.id.toString(), event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              bool hasReached = searchGarudaJournal
                      .data!.resultGaruda.journalGaruda.isEmpty ||
                  searchGarudaJournal.data!.resultGaruda.journalGaruda.length <
                      defaultLimit;
              emit(GarudaSearchingJournalLoaded(
                  dataGaruda: searchGarudaJournal,
                  hasReachedMax: hasReached,
                  newPage: 1,
                  journalGaruda:
                      searchGarudaJournal.data!.resultGaruda.journalGaruda));
            });
            keywordId = event.id.toString();
            keywordJournalSearching = event.keyword.toString();
            keywordJournalList = event.keyword.toString();
          } else if (garudaSearchingJournalLoaded.hasReachedMax == false &&
              event.keyword != keywordJournalSearching) {
            emit(GarudaSearchingJournalLoading());
            final result = await searchGarudaJournalBySubject.execute(
                event.id.toString(), event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              bool hasReached = searchGarudaJournal
                      .data!.resultGaruda.journalGaruda.isEmpty ||
                  searchGarudaJournal.data!.resultGaruda.journalGaruda.length <
                      defaultLimit;
              emit(GarudaSearchingJournalLoaded(
                  dataGaruda: searchGarudaJournal,
                  hasReachedMax: hasReached,
                  newPage: 1,
                  journalGaruda:
                      searchGarudaJournal.data!.resultGaruda.journalGaruda));
            });
            keywordId = event.id.toString();
            keywordJournalSearching = event.keyword.toString();
            keywordJournalList = event.keyword.toString();
          } else if (garudaSearchingJournalLoaded.hasReachedMax &&
              event.keyword == keywordJournalSearching &&
              event.id.toString() != keywordId) {
            emit(GarudaSearchingJournalLoading());
            final result = await searchGarudaJournalBySubject.execute(
                event.id.toString(), event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              bool hasReached = searchGarudaJournal
                      .data!.resultGaruda.journalGaruda.isEmpty ||
                  searchGarudaJournal.data!.resultGaruda.journalGaruda.length <
                      defaultLimit;
              emit(GarudaSearchingJournalLoaded(
                  dataGaruda: searchGarudaJournal,
                  hasReachedMax: hasReached,
                  newPage: 1,
                  journalGaruda:
                      searchGarudaJournal.data!.resultGaruda.journalGaruda));
            });
            keywordId = event.id.toString();
            keywordJournalSearching = event.keyword.toString();
            keywordJournalList = event.keyword.toString();
          } else if (garudaSearchingJournalLoaded.hasReachedMax == false &&
              event.keyword == keywordJournalSearching &&
              event.id.toString() != keywordId) {
            emit(GarudaSearchingJournalLoading());
            final result = await searchGarudaJournalBySubject.execute(
                event.id.toString(), event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              bool hasReached = searchGarudaJournal
                      .data!.resultGaruda.journalGaruda.isEmpty ||
                  searchGarudaJournal.data!.resultGaruda.journalGaruda.length <
                      defaultLimit;
              emit(GarudaSearchingJournalLoaded(
                  dataGaruda: searchGarudaJournal,
                  hasReachedMax: hasReached,
                  newPage: 1,
                  journalGaruda:
                      searchGarudaJournal.data!.resultGaruda.journalGaruda));
            });
            keywordId = event.id.toString();
            keywordJournalSearching = event.keyword.toString();
            keywordJournalList = event.keyword.toString();
          } else if (garudaSearchingJournalLoaded.hasReachedMax &&
              event.keyword == keywordJournalSearching &&
              keywordId != "") {
            print('MAX!! Filter');
          } else {
            int newPage = garudaSearchingJournalLoaded.newPage + 1;
            final result = await searchGarudaJournalBySubject.execute(
                event.id.toString(), event.keyword.toString(), newPage);
            await result.fold((failure) async {
              emit(GarudaSearchingJournalNotFound());
            }, (searchGarudaJournal) async {
              bool hasReached = searchGarudaJournal
                      .data!.resultGaruda.journalGaruda.isEmpty ||
                  searchGarudaJournal.data!.resultGaruda.journalGaruda.length <
                      defaultLimit;
              emit(GarudaSearchingJournalLoaded(
                  dataGaruda: searchGarudaJournal,
                  hasReachedMax: hasReached,
                  newPage: newPage,
                  journalGaruda: garudaSearchingJournalLoaded.journalGaruda +
                      searchGarudaJournal.data!.resultGaruda.journalGaruda));
            });
          }
        } else {
          emit(GarudaSearchingJournalLoading());
          final result = await searchGarudaJournalBySubject.execute(
              event.id.toString(), event.keyword.toString(), 1);
          await result.fold((failure) async {
            emit(GarudaSearchingJournalNotFound());
          }, (searchGarudaJournal) async {
            bool hasReached = searchGarudaJournal
                    .data!.resultGaruda.journalGaruda.isEmpty ||
                searchGarudaJournal.data!.resultGaruda.journalGaruda.length <
                    defaultLimit;
            emit(GarudaSearchingJournalLoaded(
                dataGaruda: searchGarudaJournal,
                hasReachedMax: hasReached,
                newPage: 1,
                journalGaruda:
                    searchGarudaJournal.data!.resultGaruda.journalGaruda));
          });
          keywordId = event.id.toString();
          keywordJournalSearching = event.keyword.toString();
          keywordJournalList = event.keyword.toString();
        }
      } else {
        emit(GarudaSearchingJournalNoInternet());
      }
    } catch (e) {
      emit(GarudaSearchingJournalNoInternet());
    }
  }
}
