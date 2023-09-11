import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:app/domain/usecases/beasiswa/searchListBeasiswa.dart';
import 'package:app/domain/usecases/beasiswa/searchListBeasiswaFilter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_beasiswa_event.dart';
part 'search_beasiswa_state.dart';

class SearchBeasiswaBloc
    extends Bloc<SearchBeasiswaEvent, SearchBeasiswaState> {
  SearchListBeasiswa searchListBeasiswa;
  InternetCheck internetCheck;
  String keywordBeasiswa = "";
  String keywordBeasiswaFilter = "";
  String keywordIdFilter = "";
  SearchListBeasiswaFilter searchListBeasiswaFilter;

  SearchBeasiswaBloc(
      {required this.searchListBeasiswa,
      required this.internetCheck,
      required this.searchListBeasiswaFilter})
      : super(SearchBeasiswaInitState()) {
    on<InitFetchSearchBeasiswaEvent>(_initSearchKeyword);
    on<FetchSearchBeasiswaEvent>(_searchKeyword);
    on<FetchSearchBeasiswaFilterEvent>(_searchKeywordByFilter);
  }

  void _initSearchKeyword(InitFetchSearchBeasiswaEvent event,
      Emitter<SearchBeasiswaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    final result;

    try {
      if (hasInternet) {
        emit(SearchBeasiswaLoadingState());

        if (event.closedFilter!) {
          result = await searchListBeasiswa.executeClosedFilter(
              event.keyword.toString(), 1);
        } else {
          result =
              await searchListBeasiswa.execute(event.keyword.toString(), 1);
        }

        await result.fold(
          (l) async {
            emit(SearchBeasiswaServerErrorState());
          },
          (r) async {
            emit(InitSearchBeasiswaLoadedState(
              listBeasiswa: r.data!.listBeasiswa,
              beasiswa: r,
            ));
          },
        );
      } else {
        emit(SearchBeasiswaNoInternetState());
      }
    } catch (e) {
      emit(SearchBeasiswaNoInternetState());
    }
  }

  void _searchKeyword(
      FetchSearchBeasiswaEvent event, Emitter<SearchBeasiswaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    final customDefaultLimit = 10;

    try {
      if (hasInternet) {
        if (state is SearchBeasiswaLoadedState) {
          SearchBeasiswaLoadedState searchBeasiswaLoadedState =
              state as SearchBeasiswaLoadedState;
          if (searchBeasiswaLoadedState.hasReached &&
              event.keyword != keywordBeasiswa &&
              keywordIdFilter == "") {
            emit(SearchBeasiswaLoadingState());
            final result =
                await searchListBeasiswa.execute(event.keyword.toString(), 1);
            await result.fold(
              (l) async {
                emit(SearchBeasiswaServerErrorState());
              },
              (r) async {
                bool hasReached = r.data!.listBeasiswa.isEmpty ||
                    r.data!.listBeasiswa.length < customDefaultLimit;
                emit(SearchBeasiswaLoadedState(
                    searchKeyword: event.keyword.toString(),
                    listBeasiswa: r.data!.listBeasiswa,
                    beasiswa: r,
                    hasReached: hasReached,
                    page: 1));
              },
            );
            keywordBeasiswa = event.keyword.toString();
          } else if (searchBeasiswaLoadedState.hasReached == false &&
              event.keyword != keywordBeasiswa &&
              keywordIdFilter == "") {
            emit(SearchBeasiswaLoadingState());
            final result =
                await searchListBeasiswa.execute(event.keyword.toString(), 1);
            await result.fold(
              (l) async {
                emit(SearchBeasiswaServerErrorState());
              },
              (r) async {
                bool hasReached = r.data!.listBeasiswa.isEmpty ||
                    r.data!.listBeasiswa.length < customDefaultLimit;
                emit(SearchBeasiswaLoadedState(
                    searchKeyword: event.keyword.toString(),
                    listBeasiswa: r.data!.listBeasiswa,
                    beasiswa: r,
                    hasReached: hasReached,
                    page: 1));
              },
            );
            keywordBeasiswa = event.keyword.toString();
          } else if (searchBeasiswaLoadedState.hasReached &&
              keywordIdFilter != "") {
            emit(SearchBeasiswaLoadingState());
            final result =
                await searchListBeasiswa.execute(event.keyword.toString(), 1);
            await result.fold(
              (l) async {
                emit(SearchBeasiswaServerErrorState());
              },
              (r) async {
                bool hasReached = r.data!.listBeasiswa.isEmpty ||
                    r.data!.listBeasiswa.length < customDefaultLimit;
                emit(SearchBeasiswaLoadedState(
                    searchKeyword: event.keyword.toString(),
                    listBeasiswa: r.data!.listBeasiswa,
                    beasiswa: r,
                    hasReached: hasReached,
                    page: 1));
                keywordIdFilter = "";
              },
            );
            keywordBeasiswa = event.keyword.toString();
          } else if (searchBeasiswaLoadedState.hasReached == false &&
              keywordIdFilter != "") {
            emit(SearchBeasiswaLoadingState());
            final result =
                await searchListBeasiswa.execute(event.keyword.toString(), 1);
            await result.fold(
              (l) async {
                emit(SearchBeasiswaServerErrorState());
              },
              (r) async {
                bool hasReached = r.data!.listBeasiswa.isEmpty ||
                    r.data!.listBeasiswa.length < customDefaultLimit;
                emit(SearchBeasiswaLoadedState(
                    searchKeyword: event.keyword.toString(),
                    listBeasiswa: r.data!.listBeasiswa,
                    beasiswa: r,
                    hasReached: hasReached,
                    page: 1));
                keywordIdFilter = "";
              },
            );
            keywordBeasiswa = event.keyword.toString();
          } else if (searchBeasiswaLoadedState.hasReached &&
              event.keyword == keywordBeasiswa) {
          } else {
            int newPage = searchBeasiswaLoadedState.page + 1;
            final result = await searchListBeasiswa.execute(
                event.keyword.toString(), newPage);
            await result.fold(
              (l) async {
                emit(SearchBeasiswaServerErrorState());
              },
              (r) async {
                if (r.data!.listBeasiswa.isEmpty) {
                  emit(SearchBeasiswaLoadedState(
                      searchKeyword: event.keyword.toString(),
                      listBeasiswa: searchBeasiswaLoadedState.listBeasiswa,
                      beasiswa: searchBeasiswaLoadedState.beasiswa,
                      hasReached: true,
                      page: newPage));
                } else {
                  bool hasReached = r.data!.listBeasiswa.isEmpty ||
                      r.data!.listBeasiswa.length < customDefaultLimit;
                  emit(SearchBeasiswaLoadedState(
                      searchKeyword: event.keyword.toString(),
                      listBeasiswa: searchBeasiswaLoadedState.listBeasiswa +
                          r.data!.listBeasiswa,
                      beasiswa: r,
                      hasReached: hasReached,
                      page: newPage));
                }
              },
            );
          }
        } else {
          emit(SearchBeasiswaLoadingState());
          final result =
              await searchListBeasiswa.execute(event.keyword.toString(), 1);
          await result.fold(
            (l) async {
              emit(SearchBeasiswaServerErrorState());
            },
            (r) async {
              bool hasReached = r.data!.listBeasiswa.isEmpty ||
                  r.data!.listBeasiswa.length < customDefaultLimit;
              emit(SearchBeasiswaLoadedState(
                  searchKeyword: event.keyword.toString(),
                  listBeasiswa: r.data!.listBeasiswa,
                  beasiswa: r,
                  hasReached: hasReached,
                  page: 1));
            },
          );
          keywordBeasiswa = event.keyword.toString();
        }
      } else {
        emit(SearchBeasiswaNoInternetState());
      }
    } catch (e) {
      emit(SearchBeasiswaNoInternetState());
    }
  }

  void _searchKeywordByFilter(FetchSearchBeasiswaFilterEvent event,
      Emitter<SearchBeasiswaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    final customDefaultLimit = 10;
    if (hasInternet) {
      if (state is SearchBeasiswaLoadedState) {
        SearchBeasiswaLoadedState searchBeasiswaLoadedState =
            state as SearchBeasiswaLoadedState;
        if (searchBeasiswaLoadedState.hasReached &&
            event.keyword != keywordBeasiswaFilter) {
          print('1');
          emit(SearchBeasiswaLoadingState());
          final result = await searchListBeasiswaFilter.execute(
              event.keyword.toString(), 1, event.penerima!);
          await result.fold(
            (l) async {
              emit(SearchBeasiswaServerErrorState());
            },
            (r) async {
              bool hasReached = r.data!.listBeasiswa.isEmpty ||
                  r.data!.listBeasiswa.length < customDefaultLimit;
              emit(SearchBeasiswaLoadedState(
                  searchKeyword: event.keyword.toString(),
                  listBeasiswa: r.data!.listBeasiswa,
                  beasiswa: r,
                  hasReached: hasReached,
                  page: 1));
            },
          );
          keywordIdFilter = event.penerima.toString();
          keywordBeasiswaFilter = event.keyword.toString();
          keywordBeasiswa = event.keyword.toString();
        } else if (searchBeasiswaLoadedState.hasReached == false &&
            event.keyword != keywordBeasiswaFilter) {
          print('2');
          emit(SearchBeasiswaLoadingState());
          final result = await searchListBeasiswaFilter.execute(
              event.keyword.toString(), 1, event.penerima!);
          await result.fold(
            (l) async {
              emit(SearchBeasiswaServerErrorState());
            },
            (r) async {
              bool hasReached = r.data!.listBeasiswa.isEmpty ||
                  r.data!.listBeasiswa.length < customDefaultLimit;
              emit(SearchBeasiswaLoadedState(
                  searchKeyword: event.keyword.toString(),
                  listBeasiswa: r.data!.listBeasiswa,
                  beasiswa: r,
                  hasReached: hasReached,
                  page: 1));
            },
          );
          keywordIdFilter = event.penerima.toString();
          keywordBeasiswaFilter = event.keyword.toString();
          keywordBeasiswa = event.keyword.toString();
        } else if (searchBeasiswaLoadedState.hasReached &&
            event.keyword == keywordBeasiswaFilter &&
            event.penerima.toString() != keywordIdFilter) {
          print('3');
          emit(SearchBeasiswaLoadingState());
          final result = await searchListBeasiswaFilter.execute(
              event.keyword.toString(), 1, event.penerima!);
          await result.fold(
            (l) async {
              emit(SearchBeasiswaServerErrorState());
            },
            (r) async {
              bool hasReached = r.data!.listBeasiswa.isEmpty ||
                  r.data!.listBeasiswa.length < customDefaultLimit;
              emit(SearchBeasiswaLoadedState(
                  searchKeyword: event.keyword.toString(),
                  listBeasiswa: r.data!.listBeasiswa,
                  beasiswa: r,
                  hasReached: hasReached,
                  page: 1));
            },
          );
          keywordIdFilter = event.penerima.toString();
          keywordBeasiswaFilter = event.keyword.toString();
          keywordBeasiswa = event.keyword.toString();
        } else if (searchBeasiswaLoadedState.hasReached == false &&
            event.keyword == keywordBeasiswaFilter &&
            event.penerima.toString() != keywordIdFilter) {
          print('4');
          emit(SearchBeasiswaLoadingState());
          final result = await searchListBeasiswaFilter.execute(
              event.keyword.toString(), 1, event.penerima!);
          await result.fold(
            (l) async {
              emit(SearchBeasiswaServerErrorState());
            },
            (r) async {
              bool hasReached = r.data!.listBeasiswa.isEmpty ||
                  r.data!.listBeasiswa.length < customDefaultLimit;
              emit(SearchBeasiswaLoadedState(
                  searchKeyword: event.keyword.toString(),
                  listBeasiswa: r.data!.listBeasiswa,
                  beasiswa: r,
                  hasReached: hasReached,
                  page: 1));
            },
          );
          keywordIdFilter = event.penerima.toString();
          keywordBeasiswaFilter = event.keyword.toString();
          keywordBeasiswa = event.keyword.toString();
        } else if (searchBeasiswaLoadedState.hasReached &&
            event.keyword == keywordBeasiswaFilter &&
            keywordIdFilter != "") {
          print('5');
        } else {
          print('else');
          print(
              'searchBeasiswaLoadedState.hasReached ${searchBeasiswaLoadedState.hasReached}');
          print('keywordIdFilter $keywordIdFilter');
          print('keywordBeasiswaFilter $keywordBeasiswaFilter');
          print('keywordBeasiswa $keywordBeasiswa');
          int newPage = searchBeasiswaLoadedState.page + 1;
          final result = await searchListBeasiswaFilter.execute(
              event.keyword.toString(), newPage, event.penerima!);
          await result.fold((l) async {
            emit(SearchBeasiswaNoInternetState());
          }, (r) async {
            if (r.data!.listBeasiswa.isEmpty) {
              emit(SearchBeasiswaLoadedState(
                  searchKeyword: event.keyword.toString(),
                  listBeasiswa: searchBeasiswaLoadedState.listBeasiswa,
                  beasiswa: searchBeasiswaLoadedState.beasiswa,
                  hasReached: true,
                  page: newPage));
            } else {
              bool hasReached = r.data!.listBeasiswa.isEmpty ||
                  r.data!.listBeasiswa.length < customDefaultLimit;
              emit(SearchBeasiswaLoadedState(
                  searchKeyword: event.keyword.toString(),
                  listBeasiswa: searchBeasiswaLoadedState.listBeasiswa +
                      r.data!.listBeasiswa,
                  beasiswa: r,
                  hasReached: hasReached,
                  page: newPage));
            }
          });
        }
      } else {
        print('init');
        emit(SearchBeasiswaLoadingState());
        final result = await searchListBeasiswaFilter.execute(
            event.keyword.toString(), 1, event.penerima!);
        await result.fold(
          (l) async {
            emit(SearchBeasiswaServerErrorState());
          },
          (r) async {
            bool hasReached = r.data!.listBeasiswa.isEmpty ||
                r.data!.listBeasiswa.length < customDefaultLimit;
            emit(SearchBeasiswaLoadedState(
                searchKeyword: event.keyword.toString(),
                listBeasiswa: r.data!.listBeasiswa,
                beasiswa: r,
                hasReached: hasReached,
                page: 1));
          },
        );
        keywordIdFilter = event.penerima.toString();
        keywordBeasiswaFilter = event.keyword.toString();
        keywordBeasiswa = event.keyword.toString();
      }
    } else {
      emit(SearchBeasiswaNoInternetState());
    }
  }
}
