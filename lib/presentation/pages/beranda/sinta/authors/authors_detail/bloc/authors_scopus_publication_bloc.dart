import 'package:app/common/failure.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/domain/usecases/sinta/authors/getAuthorsScopus.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import '../../../../../../../data/source/remote/model/sinta/authors/AuthorsScopus.dart';

part 'authors_scopus_publication_event.dart';
part 'authors_scopus_publication_state.dart';

class AuthorsScopusPublicationBloc
    extends Bloc<AuthorsScopusPublicationEvent, AuthorsScopusPublicationState> {
  InternetCheck internetCheck;
  Logger log;
  GetAuthorsScopus getAuthorsScopus;

  AuthorsScopusPublicationBloc({
    required this.internetCheck,
    required this.log,
    required this.getAuthorsScopus,
  }) : super(AuthorsScopusPublicationLoading()) {
    on<GetAuthorsScopusEvent>(_getAuthorsScopus);
  }

  void _getAuthorsScopus(GetAuthorsScopusEvent event,
      Emitter<AuthorsScopusPublicationState> emit) async {
    log.i("_getAuthorsScopus: ${event.nidn}");
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is AuthorsScopusPublicationLoaded) {
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

  Future whenHaveInternetLoaded(GetAuthorsScopusEvent event,
      Emitter<AuthorsScopusPublicationState> emit) async {
    AuthorsScopusPublicationLoaded authorsListLoaded =
        state as AuthorsScopusPublicationLoaded;
    if (authorsListLoaded.hasReachedMax) {
      await whenHaveInternetLoadedSameKeywordHasReachedMax();
    } else if (!authorsListLoaded.hasReachedMax) {
      await whenHaveInternetLoadedSameKeyword(event, emit, authorsListLoaded);
    }
  }

  Future whenHaveInternetLoadedSameKeywordHasReachedMax() async {
    log.i("whenHaveInternetLoadedSameKeywordHasReachedMax: ");
  }

  Future whenHaveInternetFirstTime(GetAuthorsScopusEvent event,
      Emitter<AuthorsScopusPublicationState> emit) async {
    emit(AuthorsScopusPublicationLoading());
    final result =
        await getAuthorsScopus.execute(event.nidn, defaultLimit, 1, 1);

    await result.fold(
      (failure) async {
        log.i("whenHaveInternetFirstTime: ${event.nidn} FAILURE");
        whenError(failure, emit);
      },
      (authorsScopus) async {
        log.i("whenHaveInternetFirstTime: ${event.nidn} SUCCESS");
        List<Scopus> list = authorsScopus.data?.scopus ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
        emit(
          AuthorsScopusPublicationLoaded(
            totalItem: authorsScopus.data?.total ?? list.length,
            page: 1,
            listScopus: list,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future whenHaveInternetLoadedSameKeyword(
    GetAuthorsScopusEvent event,
    Emitter<AuthorsScopusPublicationState> emit,
    AuthorsScopusPublicationLoaded state,
  ) async {
    int page = state.page + 1;
    final result =
        await getAuthorsScopus.execute(event.nidn, defaultLimit, page, 1);
    await result.fold(
      (failure) async {
        log.i("whenHaveInternetLoadedSameKeyword: Failure ${event.nidn}");
        whenError(failure, emit);
      },
      (authorsScopus) async {
        List<Scopus> list = authorsScopus.data?.scopus ?? [];
        bool hasReachedMax = list.isEmpty || list.length < defaultLimit;
        Logger().i(
            "whenHaveInternetLoadedSameKeyword: ${list.length}, hasReachedMax: $hasReachedMax");
        emit(AuthorsScopusPublicationLoaded(
          totalItem: authorsScopus.data?.total ?? list.length,
          page: page,
          listScopus: state.listScopus + list,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  Future whenError(
      Failure failure, Emitter<AuthorsScopusPublicationState> emit) async {
    emit(AuthorsScopusPublicationNotFound());
  }

  Future whenNoInternet(Emitter<AuthorsScopusPublicationState> emit) async {
    //ketika gk ada internet, cek dulu ini udah pernah ke loaded atau belum
    //tujuannya ketika sudah ke load dan ternyata gk ada internet, yg udh keload gk ilang
    if (state is AuthorsScopusPublicationLoaded) {
      log.i("whenNoInternetLoaded");
    } else {
      log.i("whenNoInternet");
      emit(AuthorsScopusPublicationNoInternet());
    }
  }
}
