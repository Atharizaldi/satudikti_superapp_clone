import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/garuda/garudaPaper.dart';
import 'package:app/domain/usecases/garuda/searchGarudaPaper.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'garuda_paper_event.dart';
part 'garuda_paper_state.dart';

class GarudaPaperBloc extends Bloc<GarudaPaperEvent, GarudaPaperState> {
  String keywordSearchPaper = "";
  SearchGarudaPaper searchGarudaPaper;
  InternetCheck internetCheck;
  GarudaPaperBloc(
      {required this.searchGarudaPaper, required this.internetCheck})
      : super(GarudaPaperInitial()) {
    on<GarudaPaperSearchEvent>(_searchGarudaPaper);
  }

  void _searchGarudaPaper(
      GarudaPaperSearchEvent event, Emitter<GarudaPaperState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        if (state is GarudaPaperLoaded) {
          GarudaPaperLoaded garudaPaperLoaded = state as GarudaPaperLoaded;
          if (garudaPaperLoaded.hasReachedMax &&
              event.keyword != keywordSearchPaper) {
            emit(GarudaPaperLoading());
            final result =
                await searchGarudaPaper.execute(event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaPaperServerProblem());
            }, (listPaperGaruda) async {
              if (listPaperGaruda.data!.listPaperGaruda.isEmpty) {
                emit(GarudaPaperNotFound());
              } else {
                bool hasReached = listPaperGaruda
                        .data!.listPaperGaruda.isEmpty ||
                    listPaperGaruda.data!.listPaperGaruda.length < defaultLimit;
                emit(GarudaPaperLoaded(
                    hasReachedMax: hasReached,
                    newPage: 1,
                    garudaPaperObject: listPaperGaruda,
                    garudaPaper: listPaperGaruda.data!.listPaperGaruda));
              }
              keywordSearchPaper = event.keyword.toString();
            });
          } else if (garudaPaperLoaded.hasReachedMax &&
              event.keyword == keywordSearchPaper) {
          } else if (garudaPaperLoaded.hasReachedMax == false &&
              event.keyword != keywordSearchPaper) {
            emit(GarudaPaperLoading());
            final result =
                await searchGarudaPaper.execute(event.keyword.toString(), 1);
            await result.fold((failure) async {
              emit(GarudaPaperServerProblem());
            }, (listPaperGaruda) async {
              if (listPaperGaruda.data!.listPaperGaruda.isEmpty) {
                emit(GarudaPaperNotFound());
              } else {
                bool hasReached = listPaperGaruda
                        .data!.listPaperGaruda.isEmpty ||
                    listPaperGaruda.data!.listPaperGaruda.length < defaultLimit;
                emit(GarudaPaperLoaded(
                    hasReachedMax: hasReached,
                    newPage: 1,
                    garudaPaperObject: listPaperGaruda,
                    garudaPaper: listPaperGaruda.data!.listPaperGaruda));
              }
              keywordSearchPaper = event.keyword.toString();
            });
          } else {
            int newPage = garudaPaperLoaded.newPage + 1;
            final result = await searchGarudaPaper.execute(
                event.keyword.toString(), newPage);
            await result.fold((failure) async {
              emit(GarudaPaperServerProblem());
            }, (listPaperGaruda) async {
              if (listPaperGaruda.data!.listPaperGaruda.isNotEmpty) {
                bool hasReached = listPaperGaruda
                        .data!.listPaperGaruda.isEmpty ||
                    listPaperGaruda.data!.listPaperGaruda.length < defaultLimit;
                emit(GarudaPaperLoaded(
                    hasReachedMax: hasReached,
                    newPage: newPage,
                    garudaPaperObject: listPaperGaruda,
                    garudaPaper: garudaPaperLoaded.garudaPaper +
                        listPaperGaruda.data!.listPaperGaruda));
              }
            });
          }
        } else {
          emit(GarudaPaperLoading());
          final result =
              await searchGarudaPaper.execute(event.keyword.toString(), 1);
          await result.fold((failure) async {
            emit(GarudaPaperServerProblem());
          }, (listPaperGaruda) async {
            if (listPaperGaruda.data!.listPaperGaruda.isEmpty) {
              emit(GarudaPaperNotFound());
            } else {
              bool hasReached = listPaperGaruda.data!.listPaperGaruda.isEmpty ||
                  listPaperGaruda.data!.listPaperGaruda.length < defaultLimit;
              emit(GarudaPaperLoaded(
                  hasReachedMax: hasReached,
                  newPage: 1,
                  garudaPaperObject: listPaperGaruda,
                  garudaPaper: listPaperGaruda.data!.listPaperGaruda));
            }
            keywordSearchPaper = event.keyword.toString();
          });
        }
      } else {
        emit(GarudaPaperNoInternet());
      }
    } catch (e) {
      emit(GarudaPaperNoInternet());
    }
  }
}
