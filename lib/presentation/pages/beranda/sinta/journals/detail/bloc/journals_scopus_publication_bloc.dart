import 'package:app/common/failure.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsScholar.dart';
import 'package:app/domain/usecases/sinta/journals/getJournalsScholar.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'journals_scopus_publication_event.dart';
part 'journals_scopus_publication_state.dart';

class JournalsScopusPublicationBloc extends Bloc<JournalsScopusPublicationEvent,
    JournalsScopusPublicationState> {
  InternetCheck internetCheck;
  Logger log;
  GetJournalsScholar getJournalsScholar;

  JournalsScopusPublicationBloc({
    required this.internetCheck,
    required this.log,
    required this.getJournalsScholar,
  }) : super(JournalsScopusPublicationLoading()) {
    on<GetJournalsScopusEvent>(_getJournalsScopus);
  }

  void _getJournalsScopus(GetJournalsScopusEvent event,
      Emitter<JournalsScopusPublicationState> emit) async {
    log.i("_getJournalsScopus: ${event.id}");
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is JournalsScopusPublicationLoaded) {
        await whenHaveInternetLoaded(event, emit);
      } else {
        await whenHaveInternetFirstTime(
          event,
          emit,
        );
      }
    } else {
      await whenNoInternet(emit);
    }
  }

  Future whenHaveInternetLoaded(GetJournalsScopusEvent event,
      Emitter<JournalsScopusPublicationState> emit) async {
    JournalsScopusPublicationLoaded affiliationsListLoaded =
        state as JournalsScopusPublicationLoaded;
    if (affiliationsListLoaded.hasReachedMax) {
      await whenHaveInternetLoadedSameKeywordHasReachedMax();
    } else if (!affiliationsListLoaded.hasReachedMax) {
      await whenHaveInternetLoadedSameKeyword(
          event, emit, affiliationsListLoaded);
    }
  }

  Future whenHaveInternetLoadedSameKeywordHasReachedMax() async {
    log.i("whenHaveInternetLoadedSameKeywordHasReachedMax: ");
  }

  Future whenHaveInternetFirstTime(GetJournalsScopusEvent event,
      Emitter<JournalsScopusPublicationState> emit) async {
    emit(JournalsScopusPublicationLoading());
    final result =
        await getJournalsScholar.execute(event.id, defaultLimit, 1, 1);

    await result.fold(
      (failure) async {
        log.i("whenHaveInternetFirstTime: ${event.id} FAILURE");
        whenError(failure, emit);
      },
      (authorsScopus) async {
        log.i("whenHaveInternetFirstTime: ${event.id} SUCCESS");
        List<Google> list = authorsScopus.data?.google ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
        emit(
          JournalsScopusPublicationLoaded(
            totalItem: authorsScopus.data?.total ?? list.length,
            page: 1,
            list: list,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future whenHaveInternetLoadedSameKeyword(
    GetJournalsScopusEvent event,
    Emitter<JournalsScopusPublicationState> emit,
    JournalsScopusPublicationLoaded state,
  ) async {
    int page = state.page + 1;
    final result =
        await getJournalsScholar.execute(event.id, defaultLimit, page, 1);
    await result.fold(
      (failure) async {
        log.i("whenHaveInternetLoadedSameKeyword: Failure ${event.id}");
        whenError(failure, emit);
      },
      (journalsScopus) async {
        List<Google> list = journalsScopus.data?.google ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
        Logger().i(
            "whenHaveInternetLoadedSameKeyword: ${list.length}, hasReachedMax: $hasReachedMax");
        emit(JournalsScopusPublicationLoaded(
          totalItem: journalsScopus.data?.total ?? list.length,
          page: page,
          list: state.list + list,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  Future whenError(
      Failure failure, Emitter<JournalsScopusPublicationState> emit) async {
    emit(JournalsScopusPublicationNotFound());
  }

  Future whenNoInternet(Emitter<JournalsScopusPublicationState> emit) async {
    //ketika gk ada internet, cek dulu ini udah pernah ke loaded atau belum
    //tujuannya ketika sudah ke load dan ternyata gk ada internet, yg udh keload gk ilang
    if (state is JournalsScopusPublicationLoaded) {
      log.i("whenNoInternetLoaded");
    } else {
      log.i("whenNoInternet");
      emit(JournalsScopusPublicationNoInternet());
    }
  }
}
