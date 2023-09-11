import 'dart:async';

import 'package:app/common/failure.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/domain/usecases/sinta/authors/getAuthorsList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import '../../../../../../../data/source/remote/model/sinta/authors/AuthorsList.dart';

part 'authors_list_event.dart';
part 'authors_list_state.dart';

class AuthorsListBloc extends Bloc<AuthorsListEvent, AuthorsListState> {
  InternetCheck internetCheck;
  GetAuthorsList getAuthorsList;
  Logger log;

  String keywordSearch = "";

  AuthorsListBloc(
      {required this.internetCheck,
      required this.getAuthorsList,
      required this.log})
      : super(AuthorsListInitial()) {
    on<GetAuthorsListEvent>(_getAuthorsList);
  }

  void _getAuthorsList(
      GetAuthorsListEvent event, Emitter<AuthorsListState> emit) async {
    log.i("_getAuthorsList: ${event.keyword}");
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is AuthorsListLoaded) {
        await whenHaveInternetLoaded(event, emit);
      } else {
        await whenHaveInternetFirstTime(event, emit);
      }
    } else {
      await whenNoInternet(emit);
    }
  }

  Future whenHaveInternetLoaded(
      GetAuthorsListEvent event, Emitter<AuthorsListState> emit) async {
    AuthorsListLoaded authorsListLoaded = state as AuthorsListLoaded;
    if (authorsListLoaded.hasReachedMax && event.keyword == keywordSearch) {
      await whenHaveInternetLoadedSameKeywordHasReachedMax();
    } else if (event.keyword != keywordSearch) {
      await whenHaveInternetFirstTime(event, emit);
    } else if (!authorsListLoaded.hasReachedMax &&
        event.keyword == keywordSearch) {
      await whenHaveInternetLoadedSameKeyword(event, emit, authorsListLoaded);
    }
  }

  Future whenHaveInternetLoadedSameKeywordHasReachedMax() async {
    log.i("whenHaveInternetLoadedSameKeywordHasReachedMax: ");
  }

  Future whenHaveInternetFirstTime(
      GetAuthorsListEvent event, Emitter<AuthorsListState> emit) async {
    emit(AuthorsListLoading());

    if (event.top == true) {
      final result =
          await getAuthorsList.execute(defaultLimit, 1, 1, event.keyword);
      await result.fold(
        (failure) async {
          log.i("whenHaveInternetFirstTime: ${event.keyword} FAILURE");
          whenError(failure, emit);
        },
        (response) async {
          log.i("whenHaveInternetFirstTime: ${event.keyword} SUCCESS");
          List<Authors> list = response.data?.authors ?? [];
          bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
          emit(
            AuthorsListLoaded(
              totalItem: 50,
              hasReachedMax: hasReachedMax,
              page: 1,
              authorsList: list,
            ),
          );

          keywordSearch = event.keyword;
        },
      );
    } else if (event.top == false) {
      final result =
          await getAuthorsList.execute(defaultLimit, 1, 1, event.keyword);
      await result.fold(
        (failure) async {
          log.i("whenHaveInternetFirstTime: ${event.keyword} FAILURE");
          whenError(failure, emit);
        },
        (response) async {
          log.i("whenHaveInternetFirstTime: ${event.keyword} SUCCESS");
          List<Authors> list = response.data?.authors ?? [];
          bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
          emit(
            AuthorsListLoaded(
              totalItem: response.data?.total ?? list.length,
              hasReachedMax: hasReachedMax,
              page: 1,
              authorsList: list,
            ),
          );

          keywordSearch = event.keyword;
        },
      );
    }
  }

  Future whenHaveInternetLoadedSameKeyword(GetAuthorsListEvent event,
      Emitter<AuthorsListState> emit, AuthorsListLoaded state) async {
    log.i("whenHaveInternetLoadedSameKeyword: ${event.keyword}");
    if (event.top == true) {
      int page = state.page + 1;
      final result =
          await getAuthorsList.execute(defaultLimit, page, 1, event.keyword);
      await result.fold(
        (failure) async {
          log.i("whenHaveInternetLoadedSameKeyword: Failure ${event.keyword}");
          whenError(failure, emit);
        },
        (response) async {
          log.i("whenHaveInternetLoadedSameKeyword: Success ${event.keyword}");
          List<Authors> list = response.data?.authors ?? [];
          bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
          if (page <= 5) {
            if (page == 5) {
              hasReachedMax = true;
            }
            emit(AuthorsListLoaded(
              totalItem: 50,
              hasReachedMax: hasReachedMax,
              page: page,
              authorsList: state.authorsList + list,
            ));
          }
        },
      );
    } else if (event.top == false) {
      int page = state.page + 1;
      final result =
          await getAuthorsList.execute(defaultLimit, page, 1, event.keyword);
      await result.fold((failure) async {
        log.i("whenHaveInternetLoadedSameKeyword: Failure ${event.keyword}");
        whenError(failure, emit);
      }, (response) async {
        log.i("whenHaveInternetLoadedSameKeyword: Success ${event.keyword}");
        List<Authors> list = response.data?.authors ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;

        emit(AuthorsListLoaded(
          totalItem: response.data?.total ?? list.length,
          hasReachedMax: hasReachedMax,
          page: page,
          authorsList: state.authorsList + list,
        ));
      });
    }
  }

  Future whenError(Failure failure, Emitter<AuthorsListState> emit) async {
    emit(AuthorsListError());
  }

  Future whenNoInternet(Emitter<AuthorsListState> emit) async {
    //ketika gk ada internet, cek dulu ini udah pernah ke loaded atau belum
    //tujuannya ketika sudah ke load dan ternyata gk ada internet, yg udh keload gk ilang
    if (state is AuthorsListLoaded) {
      log.i("whenNoInternetLoaded");
    } else {
      log.i("whenNoInternet");
      emit(AuthorsListNoInternet());
    }
  }
}
