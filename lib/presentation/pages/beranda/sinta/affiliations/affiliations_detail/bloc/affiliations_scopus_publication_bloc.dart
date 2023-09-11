import 'package:app/common/failure.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsScopus.dart';
import 'package:app/domain/usecases/sinta/affiliations/getAffiliationsScopus.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'affiliations_scopus_publication_event.dart';
part 'affiliations_scopus_publication_state.dart';

class AffiliationsScopusPublicationBloc extends Bloc<
    AffiliationsScopusPublicationEvent, AffiliationsScopusPublicationState> {
  InternetCheck internetCheck;
  Logger log;
  GetAffiliationsScopus getAffiliationsScopus;

  AffiliationsScopusPublicationBloc({
    required this.internetCheck,
    required this.log,
    required this.getAffiliationsScopus,
  }) : super(AffiliationsScopusPublicationLoading()) {
    on<GetAffiliationsScopusEvent>(_getAffiliationsScopus);
  }

  void _getAffiliationsScopus(GetAffiliationsScopusEvent event,
      Emitter<AffiliationsScopusPublicationState> emit) async {
    log.i("_getAffiliationsScopus: ${event.id}");
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is AffiliationsScopusPublicationLoaded) {
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

  Future whenHaveInternetLoaded(GetAffiliationsScopusEvent event,
      Emitter<AffiliationsScopusPublicationState> emit) async {
    AffiliationsScopusPublicationLoaded affiliationsListLoaded =
        state as AffiliationsScopusPublicationLoaded;
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

  Future whenHaveInternetFirstTime(GetAffiliationsScopusEvent event,
      Emitter<AffiliationsScopusPublicationState> emit) async {
    emit(AffiliationsScopusPublicationLoading());
    final result =
        await getAffiliationsScopus.execute(event.id, defaultLimit, 1, 1);

    await result.fold(
      (failure) async {
        log.i("whenHaveInternetFirstTime: ${event.id} FAILURE");
        whenError(failure, emit);
      },
      (authorsScopus) async {
        log.i("whenHaveInternetFirstTime: ${event.id} SUCCESS");
        List<Documents> list = authorsScopus.data?.results?.documents ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
        emit(
          AffiliationsScopusPublicationLoaded(
            totalItem: authorsScopus.data?.results?.total ?? list.length,
            page: 1,
            documents: list,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future whenHaveInternetLoadedSameKeyword(
    GetAffiliationsScopusEvent event,
    Emitter<AffiliationsScopusPublicationState> emit,
    AffiliationsScopusPublicationLoaded state,
  ) async {
    int page = state.page + 1;
    final result =
        await getAffiliationsScopus.execute(event.id, defaultLimit, page, 1);
    await result.fold(
      (failure) async {
        log.i("whenHaveInternetLoadedSameKeyword: Failure ${event.id}");
        whenError(failure, emit);
      },
      (affiliationsScopus) async {
        List<Documents> list =
            affiliationsScopus.data?.results?.documents ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
        Logger().i(
            "whenHaveInternetLoadedSameKeyword: ${list.length}, hasReachedMax: $hasReachedMax");
        emit(AffiliationsScopusPublicationLoaded(
          totalItem: affiliationsScopus.data?.results?.total ?? list.length,
          page: page,
          documents: state.documents + list,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  Future whenError(
      Failure failure, Emitter<AffiliationsScopusPublicationState> emit) async {
    emit(AffiliationsScopusPublicationNotFound());
  }

  Future whenNoInternet(
      Emitter<AffiliationsScopusPublicationState> emit) async {
    //ketika gk ada internet, cek dulu ini udah pernah ke loaded atau belum
    //tujuannya ketika sudah ke load dan ternyata gk ada internet, yg udh keload gk ilang
    if (state is AffiliationsScopusPublicationLoaded) {
      log.i("whenNoInternetLoaded");
    } else {
      log.i("whenNoInternet");
      emit(AffiliationsScopusPublicationNoInternet());
    }
  }
}
