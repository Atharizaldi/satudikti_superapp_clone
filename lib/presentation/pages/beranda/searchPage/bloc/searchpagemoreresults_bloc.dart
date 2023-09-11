import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart' as n;
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart'
    as p;
import 'package:app/domain/usecases/berita/getNewsSearchMoreResults.dart';
import 'package:app/domain/usecases/pengumuman/getPengumumanSearchMoreResults.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'searchpagemoreresults_event.dart';
part 'searchpagemoreresults_state.dart';

class SearchpagemoreresultsBloc
    extends Bloc<SearchpagemoreresultsEvent, SearchpagemoreresultsState> {
  GetPengumumanSearchMoreResults getPengumumanSearchMoreResults;
  GetNewsSearchMoreResults getNewsSearchMoreResults;
  Logger log;
  InternetCheck internetCheck;
  String keyword1 = "";

  SearchpagemoreresultsBloc({
    required this.getPengumumanSearchMoreResults,
    required this.getNewsSearchMoreResults,
    required this.log,
    required this.internetCheck,
  }) : super(SearchpagemoreresultsLoadingState()) {
    on<GetMorePengumumanResultsEvent>(_getMorePengumumanResultsEvent);
    on<GetMoreNewsResultsEvent>(_getMoreNewsResultsEvent);
  }

  void _getMorePengumumanResultsEvent(GetMorePengumumanResultsEvent event,
      Emitter<SearchpagemoreresultsState> emit) async {
    bool check = await internetCheck.hasConnection();

    if (check) {
      if (state is SearchpagemoreresultsPengumumanLoadedState && keyword1 == event.keyword) {
        final loadedState = state as SearchpagemoreresultsPengumumanLoadedState;
        if (loadedState.hasReachedMax) {
          return;
        } else {
          int newPage = loadedState.page + 1;

          final result = await getPengumumanSearchMoreResults.execute(
            event.keyword,
            newPage.toString(),
          );

          await result.fold((failure) async {
            emit(SearchpagemoreresultsPengumumanLoadedState(
              page: newPage - 1,
              pengumumanList: loadedState.pengumumanList,
              hasReachedMax: true,
            ));
          }, (pengumumanList) async {
            bool hasReachedMax =
                pengumumanList.data.isEmpty || pengumumanList.data.length < 10;
            emit(SearchpagemoreresultsPengumumanLoadedState(
              page: newPage,
              pengumumanList: loadedState.pengumumanList + pengumumanList.data,
              hasReachedMax: hasReachedMax,
            ));
          });
        }
      } else {
        keyword1 = event.keyword;
        final result =
            await getPengumumanSearchMoreResults.execute(event.keyword, '1');

        await result.fold((failure) async {
          emit(SearchpagemoreresultsNoInternetState());
        }, (pengumumanList) async {
          bool hasReached =
              pengumumanList.data.isEmpty || pengumumanList.data.length < 10;
          emit(
            SearchpagemoreresultsPengumumanLoadedState(
              page: 1,
              pengumumanList: pengumumanList.data,
              hasReachedMax: hasReached,
            ),
          );
        });
      }
    } else {
      if (state is SearchpagemoreresultsPengumumanLoadedState) {
        return;
      } else {
        emit(SearchpagemoreresultsNoInternetState());
      }
    }
  }

  void _getMoreNewsResultsEvent(GetMoreNewsResultsEvent event,
      Emitter<SearchpagemoreresultsState> emit) async {
    bool check = await internetCheck.hasConnection();

    if (check) {
      if (state is SearchpagemoreresultsBeritaLoadedState && keyword1 == event.keyword) {
        final loadedState = state as SearchpagemoreresultsBeritaLoadedState;
        if (loadedState.hasReachedMax) {
          return;
        } else {
          int newPage = loadedState.page + 1;
          final result = await getNewsSearchMoreResults.execute(
            event.keyword,
            newPage.toString(),
          );

          await result.fold((failure) async {
            emit(SearchpagemoreresultsBeritaLoadedState(
              page: newPage - 1,
              newsList: loadedState.newsList,
              hasReachedMax: true,
            ));
          }, (newsList) async {
            bool hasReachedMax =
                newsList.data.isEmpty || newsList.data.length < 10;
            emit(SearchpagemoreresultsBeritaLoadedState(
              page: newPage,
              newsList: loadedState.newsList + newsList.data,
              hasReachedMax: hasReachedMax,
            ));
          });
        }
      } else {
        keyword1 = event.keyword;
        final result =
            await getNewsSearchMoreResults.execute(event.keyword, '1');

        await result.fold((failure) async {
          emit(SearchpagemoreresultsNoInternetState());
        }, (newsList) async {
          bool hasReached = newsList.data.isEmpty || newsList.data.length < 10;
          emit(
            SearchpagemoreresultsBeritaLoadedState(
              page: 1,
              newsList: newsList.data,
              hasReachedMax: hasReached,
            ),
          );
        });
      }
    } else {
      if (state is SearchpagemoreresultsBeritaLoadedState) {
        return;
      } else {
        emit(SearchpagemoreresultsNoInternetState());
      }
    }
  }
}
