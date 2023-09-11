import 'package:app/injection.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_list/bloc/affiliations_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/bloc/authors_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/bloc/authors_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_list/bloc/authors_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/journals_list/bloc/journals_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/search/bloc/sinta_search_bloc.dart';

void sintaBlocInjection() {
  locator.registerFactory(
    () => AuthorsListBloc(
      internetCheck: locator(),
      getAuthorsList: locator(),
      log: locator(),
    ),
  );
  locator.registerFactory(
    () => AuthorsDetailBloc(
      internetCheck: locator(),
      getAuthorsDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => AuthorsScopusPublicationBloc(
      internetCheck: locator(),
      log: locator(),
      getAuthorsScopus: locator(),
    ),
  );
  locator.registerFactory(
    () => AffiliationsListBloc(
      internetCheck: locator(),
      log: locator(),
      getAffiliationsList: locator(),
    ),
  );
  locator.registerFactory(
    () => AffiliationsDetailBloc(
      internetCheck: locator(),
      getAffiliationsDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => AffiliationsScopusPublicationBloc(
      internetCheck: locator(),
      log: locator(),
      getAffiliationsScopus: locator(),
    ),
  );
  locator.registerFactory(
    () => JournalsListBloc(
      internetCheck: locator(),
      log: locator(),
      getJournalsList: locator(),
    ),
  );
  locator.registerFactory(
    () => JournalsDetailBloc(
      internetCheck: locator(),
      getJournalsDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => JournalsScopusPublicationBloc(
      internetCheck: locator(),
      log: locator(),
      getJournalsScholar: locator(),
    ),
  );
  locator.registerFactory(
    () => SintaSearchBloc(
      internetCheck: locator(),
      log: locator(),
      getAuthorsList: locator(),
      getAffiliationsList: locator(),
      getJournalsList: locator(),
    ),
  );
}
