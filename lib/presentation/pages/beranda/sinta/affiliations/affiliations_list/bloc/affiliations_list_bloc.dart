import 'package:app/common/failure.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsList.dart';
import 'package:app/domain/usecases/sinta/affiliations/getAffiliationsList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'affiliations_list_event.dart';

part 'affiliations_list_state.dart';

class AffiliationsListBloc
    extends Bloc<AffiliationsListEvent, AffiliationsListState> {
  GetAffiliationsList getAffiliationsList;
  InternetCheck internetCheck;
  Logger log;

  String keywordSearch = "";

  AffiliationsListBloc({
    required this.internetCheck,
    required this.log,
    required this.getAffiliationsList,
  }) : super(AffiliationsListInitial()) {
    on<GetAffiliationsListEvent>(_getAffiliationsList);
  }

  void _getAffiliationsList(GetAffiliationsListEvent event,
      Emitter<AffiliationsListState> emit) async {
    log.i("_getAffiliationsList: ${event.keyword}");
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is AffiliationsListLoaded) {
        await whenHaveInternetLoaded(event, emit);
      } else {
        await whenHaveInternetFirstTime(event, emit);
      }
    } else {
      await whenNoInternet(emit);
    }
  }

  Future whenHaveInternetLoaded(GetAffiliationsListEvent event,
      Emitter<AffiliationsListState> emit) async {
    AffiliationsListLoaded affiliationsListLoaded =
        state as AffiliationsListLoaded;
    if (affiliationsListLoaded.hasReachedMax &&
        event.keyword == keywordSearch) {
      await whenHaveInternetLoadedSameKeywordHasReachedMax();
    } else if (event.keyword != keywordSearch) {
      await whenHaveInternetFirstTime(event, emit);
    } else if (!affiliationsListLoaded.hasReachedMax &&
        event.keyword == keywordSearch) {
      await whenHaveInternetLoadedSameKeyword(
          event, emit, affiliationsListLoaded);
    }
  }

  Future whenHaveInternetLoadedSameKeywordHasReachedMax() async {
    log.i("whenHaveInternetLoadedSameKeywordHasReachedMax: ");
  }

  Future whenHaveInternetFirstTime(GetAffiliationsListEvent event,
      Emitter<AffiliationsListState> emit) async {
    emit(AffiliationsListLoading());
    if(event.top == true) {
      final result =
      await getAffiliationsList.execute(defaultLimit, 1, 1, event.keyword);

      await result.fold(
            (failure) async {
          log.i("whenHaveInternetFirstTime: ${event.keyword} FAILURE");
          whenError(failure, emit);
        },
            (response) async {
          log.i("whenHaveInternetFirstTime: ${event.keyword} SUCCESS");
          List<Affiliations> list = response.data?.results?.affiliations ?? [];
          bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
          emit(
            AffiliationsListLoaded(
              totalItem: 100,
              hasReachedMax: hasReachedMax,
              page: 1,
              affiliationsList: list,
            ),
          );

          keywordSearch = event.keyword;
        },
      );
    }else if(event.top == false){
      final result =
      await getAffiliationsList.execute(defaultLimit, 1, 1, event.keyword);

      await result.fold(
            (failure) async {
          log.i("whenHaveInternetFirstTime: ${event.keyword} FAILURE");
          whenError(failure, emit);
        },
            (response) async {
          log.i("whenHaveInternetFirstTime: ${event.keyword} SUCCESS");
          List<Affiliations> list = response.data?.results?.affiliations ?? [];
          bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
          emit(
            AffiliationsListLoaded(
              totalItem: response.data?.results?.total ?? list.length,
              hasReachedMax: hasReachedMax,
              page: 1,
              affiliationsList: list,
            ),
          );

          keywordSearch = event.keyword;
        },
      );
    }
  }

  Future whenHaveInternetLoadedSameKeyword(GetAffiliationsListEvent event,
      Emitter<AffiliationsListState> emit, AffiliationsListLoaded state) async {
    log.i("whenHaveInternetLoadedSameKeyword: ${event.keyword}");
    if (event.top == true) {
      int page = state.page + 1;
      final result = await getAffiliationsList.execute(
          defaultLimit, page, 1, event.keyword);
      await result.fold(
        (failure) async {
          log.i("whenHaveInternetLoadedSameKeyword: Failure ${event.keyword}");
          // whenError(failure, emit);
          emit(AffiliationsListNotFound(totalItem: 0));
        },
        (response) async {
          log.i("whenHaveInternetLoadedSameKeyword: Success ${event.keyword}");
          List<Affiliations> list = response.data?.results?.affiliations ?? [];
          bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
          if (page <= 10) {
            if (page == 10) {
              hasReachedMax = true;
            }
            emit(AffiliationsListLoaded(
              totalItem: 100,
              hasReachedMax: hasReachedMax,
              page: page,
              affiliationsList: state.affiliationsList + list,
            ));
          }
        },
      );
    } else if (event.top == false) {
      int page = state.page + 1;
      final result = await getAffiliationsList.execute(
          defaultLimit, page, 1, event.keyword);
      await result.fold(
        (failure) async {
          log.i("whenHaveInternetLoadedSameKeyword: Failure ${event.keyword}");
          // whenError(failure, emit);
          emit(AffiliationsListNotFound(totalItem: 0));
        },
        (response) async {
          log.i("whenHaveInternetLoadedSameKeyword: Success ${event.keyword}");
          List<Affiliations> list = response.data?.results?.affiliations ?? [];
          bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
          emit(AffiliationsListLoaded(
            totalItem: response.data?.results?.total ?? list.length,
            hasReachedMax: hasReachedMax,
            page: page,
            affiliationsList: state.affiliationsList + list,
          ));
        },
      );
    }
  }

  Future whenError(Failure failure, Emitter<AffiliationsListState> emit) async {
    emit(AffiliationsListError());
  }

  Future whenNoInternet(Emitter<AffiliationsListState> emit) async {
    //ketika gk ada internet, cek dulu ini udah pernah ke loaded atau belum
    //tujuannya ketika sudah ke load dan ternyata gk ada internet, yg udh keload gk ilang
    if (state is AffiliationsListLoaded) {
      log.i("whenNoInternetLoaded");
    } else {
      log.i("whenNoInternet");
      emit(AffiliationsListNoInternet());
    }
  }
}
