import 'dart:async';

import 'package:app/common/failure.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsList.dart';
import 'package:app/domain/usecases/sinta/journals/getJournalsList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'journals_list_event.dart';
part 'journals_list_state.dart';

class JournalsListBloc extends Bloc<JournalsListEvent, JournalsListState> {
  GetJournalsList getJournalsList;
  InternetCheck internetCheck;
  Logger log;

  String keywordSearch = "";

  JournalsListBloc({
    required this.internetCheck,
    required this.log,
    required this.getJournalsList,
  }) : super(JournalsListInitial()) {
    on<GetJournalsListEvent>(_getJournalsList);
  }

  void _getJournalsList(
      GetJournalsListEvent event, Emitter<JournalsListState> emit) async {
    log.i("_getAffiliationsList: ${event.keyword}");
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is JournalsListLoaded) {
        await whenHaveInternetLoaded(event, emit);
      } else {
        await whenHaveInternetFirstTime(event, emit);
      }
    } else {
      await whenNoInternet(emit);
    }
  }

  Future whenHaveInternetLoaded(
      GetJournalsListEvent event, Emitter<JournalsListState> emit) async {
    JournalsListLoaded journalsListLoaded = state as JournalsListLoaded;
    if (journalsListLoaded.hasReachedMax && event.keyword == keywordSearch) {
      await whenHaveInternetLoadedSameKeywordHasReachedMax();
    } else if (event.keyword != keywordSearch) {
      await whenHaveInternetFirstTime(event, emit);
    } else if (!journalsListLoaded.hasReachedMax &&
        event.keyword == keywordSearch) {
      await whenHaveInternetLoadedSameKeyword(event, emit, journalsListLoaded);
    }
  }

  Future whenHaveInternetLoadedSameKeywordHasReachedMax() async {
    log.i("whenHaveInternetLoadedSameKeywordHasReachedMax: ");
  }

  Future whenHaveInternetFirstTime(
      GetJournalsListEvent event, Emitter<JournalsListState> emit) async {
    emit(JournalsListLoading());
    final result =
        await getJournalsList.execute(defaultLimit, 1, 1, event.keyword);

    await result.fold(
      (failure) async {
        log.i("whenHaveInternetFirstTime: ${event.keyword} FAILURE");
        whenError(failure, emit);
      },
      (response) async {
        log.i("whenHaveInternetFirstTime: ${event.keyword} SUCCESS");
        List<Journals> list = response.data?.journals ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
        emit(
          JournalsListLoaded(
            totalItem: response.data?.total ?? list.length,
            hasReachedMax: hasReachedMax,
            page: 1,
            journalsList: list,
          ),
        );

        keywordSearch = event.keyword;
      },
    );
  }

  Future whenHaveInternetLoadedSameKeyword(GetJournalsListEvent event,
      Emitter<JournalsListState> emit, JournalsListLoaded state) async {
    log.i("whenHaveInternetLoadedSameKeyword: ${event.keyword}");
    int page = state.page + 1;
    final result =
        await getJournalsList.execute(defaultLimit, page, 1, event.keyword);
    await result.fold(
      (failure) async {
        log.i("whenHaveInternetLoadedSameKeyword: Failure ${event.keyword}");
        whenError(failure, emit);
      },
      (response) async {
        log.i("whenHaveInternetLoadedSameKeyword: Success ${event.keyword}");
        List<Journals> list = response.data?.journals ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
        emit(JournalsListLoaded(
          totalItem: response.data?.total ?? list.length,
          hasReachedMax: hasReachedMax,
          page: page,
          journalsList: state.journalsList + list,
        ));
      },
    );
  }

  Future whenError(Failure failure, Emitter<JournalsListState> emit) async {
    emit(JournalsListError());
  }

  Future whenNoInternet(Emitter<JournalsListState> emit) async {
    //ketika gk ada internet, cek dulu ini udah pernah ke loaded atau belum
    //tujuannya ketika sudah ke load dan ternyata gk ada internet, yg udh keload gk ilang
    if (state is JournalsListLoaded) {
      log.i("whenNoInternetLoaded");
    } else {
      log.i("whenNoInternet");
      emit(JournalsListNoInternet());
    }
  }
}
