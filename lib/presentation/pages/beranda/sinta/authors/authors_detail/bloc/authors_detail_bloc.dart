import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsDetail.dart';
import 'package:app/domain/usecases/sinta/authors/getAuthorsDetail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'authors_detail_event.dart';
part 'authors_detail_state.dart';

//id 6754604
class AuthorsDetailBloc extends Bloc<AuthorsDetailEvent, AuthorsDetailState> {
  final InternetCheck internetCheck;
  final GetAuthorsDetail getAuthorsDetail;

  AuthorsDetailBloc({
    required this.internetCheck,
    required this.getAuthorsDetail,
  }) : super(AuthorsDetailLoading()) {
    on<GetAuthorsDetailEvent>(_getAuthorsDetail);
  }

  void _getAuthorsDetail(
      GetAuthorsDetailEvent event, Emitter<AuthorsDetailState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      final result = await getAuthorsDetail.execute(event.nidn);
      await result.fold(
        (failure) async {
          Logger().i("_getAuthorsDetail: failure");
          emit(AuthorsDetailLoading());
        },
        (authorsDetail) async {
          Logger().i("_getAuthorsDetail: ${authorsDetail.data?.author?.id}");
          Author author = authorsDetail.data?.author ?? Author();
          String overall = author.sintaScoreV3Overall ?? "-";
          String overall3y = author.sintaScoreV33Year ?? "-";
          String afill = author.affiliationScoreV3Overall ?? "-";
          String affil3y = author.affiliationScoreV33year ?? "-";

          emit(AuthorsDetailLoaded(
              author: author,
              overall: ((overall.isEmpty) ? "-" : overall),
              overall3y: ((overall3y.isEmpty) ? "-" : overall3y),
              afill: ((afill.isEmpty) ? "-" : afill),
              affil3y: ((affil3y.isEmpty) ? "-" : affil3y),
              tables: authorsTable(author)));
        },
      );
    } else {
      emit(AuthorsDetailLoading());
    }
  }

  List<List<String>> authorsTable(Author author) {
    String articleScopus = author.scopus?.totalDocument ?? "-";
    String articleScholar = author.google?.totalDocument ?? "-";
    String articleWos = author.wos?.totalDocument ?? "-";
    List<String> article = [
      ((articleScopus.isEmpty) ? "-" : articleScopus),
      ((articleScholar.isEmpty) ? "-" : articleScholar),
      ((articleWos.isEmpty) ? "-" : articleWos)
    ];

    String citationScopus = author.scopus?.totalCitation ?? "-";
    String citationScholar = author.google?.totalCitation ?? "-";
    String citationWos = author.wos?.totalCitation ?? "-";
    List<String> citation = [
      ((citationScopus.isEmpty) ? "-" : citationScopus),
      ((citationScholar.isEmpty) ? "-" : citationScholar),
      ((citationWos.isEmpty) ? "-" : citationWos)
    ];

    String citedScopus = author.scopus?.totalCitedDoc ?? "-";
    String citedScholar = author.google?.totalCitedDoc ?? "-";
    String citedWos = author.wos?.totalCitedDoc ?? "-";
    List<String> cited = [
      ((citedScopus.isEmpty) ? "-" : citedScopus),
      ((citedScholar.isEmpty) ? "-" : citedScholar),
      ((citedWos.isEmpty) ? "-" : citedWos)
    ];

    String hIndexScopus = author.scopus?.hIndex ?? "-";
    String hIndexScholar = author.google?.hIndex ?? "-";
    String hIndexWos = author.wos?.hIndex ?? "-";
    List<String> hIndex = [
      ((hIndexScopus.isEmpty) ? "-" : hIndexScopus),
      ((hIndexScholar.isEmpty) ? "-" : hIndexScholar),
      ((hIndexWos.isEmpty) ? "-" : hIndexWos)
    ];

    String i10IndexScopus = author.scopus?.i10Index ?? "-";
    String i10IndexScholar = author.google?.i10Index ?? "-";
    String i10IndexWos = "-";
    List<String> i10Index = [
      ((i10IndexScopus.isEmpty) ? "-" : i10IndexScopus),
      ((i10IndexScholar.isEmpty) ? "-" : i10IndexScholar),
      i10IndexWos
    ];

    String gIndexScopus = author.scopus?.gIndex ?? "-";
    String gIndexScholar = author.google?.gIndex ?? "-";
    String gIndexWos = "-";
    List<String> gIndex = [
      ((gIndexScopus.isEmpty) ? "-" : gIndexScopus),
      ((gIndexScholar.isEmpty) ? "-" : gIndexScholar),
      gIndexWos
    ];

    //scopus/scholar/wos
    //article/citation/cited/hindex/i10index/gindex/
    List<List<String>> tables = [
      article,
      citation,
      cited,
      hIndex,
      i10Index,
      gIndex
    ];
    return tables;
  }
}
