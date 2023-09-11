import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsList.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsList.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsList.dart';
import 'package:app/domain/usecases/sinta/affiliations/getAffiliationsList.dart';
import 'package:app/domain/usecases/sinta/authors/getAuthorsList.dart';
import 'package:app/domain/usecases/sinta/journals/getJournalsList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'sinta_search_event.dart';
part 'sinta_search_state.dart';

class SintaSearchBloc extends Bloc<SintaSearchEvent, SintaSearchState> {
  GetAuthorsList getAuthorsList;
  GetAffiliationsList getAffiliationsList;
  GetJournalsList getJournalsList;
  InternetCheck internetCheck;
  Logger log;

  SintaSearchBloc({
    required this.getAuthorsList,
    required this.getAffiliationsList,
    required this.getJournalsList,
    required this.internetCheck,
    required this.log,
  }) : super(SintaSearchInitial()) {
    on<GetAuthorsAffiliationsJournalsEvent>(
        _getAuthorsAffiliationsJournalsEvent);
  }

  void _getAuthorsAffiliationsJournalsEvent(
      GetAuthorsAffiliationsJournalsEvent event,
      Emitter<SintaSearchState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      emit(SintaSearchLoading());
      final resultAuthors =
          await getAuthorsList.execute(defaultLimit, 1, 1, event.keyword);
      final resultAffiliations =
          await getAffiliationsList.execute(defaultLimit, 1, 1, event.keyword);
      final resultJournals =
          await getJournalsList.execute(defaultLimit, 1, 1, event.keyword);

      int totalItemAuthors = 0;
      List<Authors> authorsList = [];
      int totalItemAffiliations = 0;
      List<Affiliations> affiliationsList = [];
      int totalItemJournals = 0;
      List<Journals> journalsList = [];

      await resultAuthors.fold(
        (failure) async {
          emit(SintaSearchError());
        },
        (response) async {
          authorsList = response.data?.authors ?? [];
          totalItemAuthors = response.data?.total ?? authorsList.length;
        },
      );

      await resultAffiliations.fold(
        (failure) async {
          emit(SintaSearchError());
        },
        (response) async {
          affiliationsList = response.data?.results?.affiliations ?? [];
          totalItemAffiliations =
              response.data?.results?.total ?? affiliationsList.length;
        },
      );

      await resultJournals.fold(
        (failure) async {
          emit(SintaSearchError());
        },
        (response) async {
          journalsList = response.data?.journals ?? [];
          totalItemJournals = response.data?.total ?? journalsList.length;
        },
      );

      emit(SintaSearchLoaded(
        totalItemAuthors: totalItemAuthors,
        authorsList: authorsList,
        totalItemAffiliations: totalItemAffiliations,
        affiliationsList: affiliationsList,
        totalItemJournals: totalItemJournals,
        journalsList: journalsList,
      ));
    } else {
      emit(SintaSearchNoInternet());
    }
  }
}
