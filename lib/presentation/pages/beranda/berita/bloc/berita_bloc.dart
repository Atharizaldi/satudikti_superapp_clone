import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/domain/usecases/berita/getNews.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'berita_event.dart';
part 'berita_state.dart';

class BeritaBloc extends Bloc<BeritaEvent, BeritaState> {
  //berita terbaru == kategori 1
  //berita popular == kategori 3

  GetNews getNews;
  Logger log;
  InternetCheck internetCheck;

  BeritaBloc(
      {required this.getNews, required this.log, required this.internetCheck})
      : super(BeritaLoadingState()) {
    on<GetBeritaEvent>(_getBerita);
  }

  void _getBerita(GetBeritaEvent event, Emitter<BeritaState> emit) async {
    bool hasConnection = await internetCheck.hasConnection();
    if (hasConnection) {
      if (state is BeritaLoadedState) {
        BeritaLoadedState beritaLoadedState = state as BeritaLoadedState;
        if (beritaLoadedState.hasReachedMax) {
          log.i("_getBerita hasReachedMax");
        } else {
          int newPage = beritaLoadedState.page + 1;
          final result = await getNews.execute(
              event.category, newPage.toString(), defaultLimit.toString());

          await result.fold(
            (failure) async {
              emit(BeritaLoadedState(
                  page: newPage - 1,
                  newsList: beritaLoadedState.newsList,
                  hasReachedMax: true));
              log.i("_getBerita emit page: ${(newPage - 1)} and hasReachedMax");
            },
            (newsList) async {
              bool hasReachedMax =
                  newsList.data.isEmpty || newsList.data.length < defaultLimit;
              emit(BeritaLoadedState(
                  page: newPage,
                  newsList: beritaLoadedState.newsList + newsList.data,
                  hasReachedMax: hasReachedMax));
              log.i(
                  "_getBerita emit page: $newPage hasReachedMax: $hasReachedMax");
            },
          );
        }
      } else {
        final result =
            await getNews.execute(event.category, "1", defaultLimit.toString());

        await result.fold(
          (failure) async {
            emit(BeritaErrorState());
          },
          (newsList) async {
            emit(BeritaLoadedState(
                page: 1, newsList: newsList.data, hasReachedMax: false));
          },
        );
      }
    } else {
      if (state is BeritaLoadedState) {
      } else {
        emit(BeritaNoInternetState());
      }
    }
  }
}
