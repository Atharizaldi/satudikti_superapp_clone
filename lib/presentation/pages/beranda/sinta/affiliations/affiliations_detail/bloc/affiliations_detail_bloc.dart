import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsDetail.dart';
import 'package:app/domain/usecases/sinta/affiliations/getAffiliationsDetail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'affiliations_detail_event.dart';
part 'affiliations_detail_state.dart';

//id 430
class AffiliationsDetailBloc
    extends Bloc<AffiliationsDetailEvent, AffiliationsDetailState> {
  InternetCheck internetCheck;
  GetAffiliationsDetail getAffiliationsDetail;

  AffiliationsDetailBloc(
      {required this.internetCheck, required this.getAffiliationsDetail})
      : super(AffiliationsDetailLoading()) {
    on<GetAffiliationsDetailEvent>(_getAffiliationsDetail);
  }

  void _getAffiliationsDetail(GetAffiliationsDetailEvent event,
      Emitter<AffiliationsDetailState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      final result = await getAffiliationsDetail.execute(event.id);
      await result.fold(
        (failure) async {
          Logger().i("_getAffiliationsDetail: failure");
          emit(AffiliationsDetailLoading());
        },
        (affiliationsDetail) async {
          Logger().i(
              "_getAffiliationsDetail: ${affiliationsDetail.data?.results?.affiliations?.first.id}");
          Affiliations affiliations =
              affiliationsDetail.data?.results?.affiliations?.first ??
                  Affiliations();
          String overall = affiliations.sintaScoreV3Overall ?? "-";
          String overall3y = affiliations.sintaScoreV33year ?? "-";
          String productivity =
              affiliations.sintaScoreV3ProductivityOverall ?? "-";
          String productivity3y =
              affiliations.sintaScoreV3Productivity3year ?? "-";

          emit(AffiliationsDetailLoaded(
              affiliations: affiliations,
              overall: ((overall.isEmpty) ? "-" : overall),
              overall3y: ((overall3y.isEmpty) ? "-" : overall3y),
              productivity: ((productivity.isEmpty) ? "-" : productivity),
              productivity3y: ((productivity3y.isEmpty) ? "-" : productivity3y),
              tables: affiliationsTable(affiliations)));
        },
      );
    } else {
      emit(AffiliationsDetailLoading());
    }
  }

  List<List<String>> affiliationsTable(Affiliations affiliations) {
    String articleScopus = affiliations.scopus?.totalDocument ?? "-";
    String articleScholar = affiliations.google?.totalDocument ?? "-";
    String articleWos = affiliations.wos?.totalDocument ?? "-";
    String articleGaruda = affiliations.garuda?.totalDocument ?? "-";
    List<String> article = [
      ((articleScopus.isEmpty) ? "-" : articleScopus),
      ((articleScholar.isEmpty) ? "-" : articleScholar),
      ((articleWos.isEmpty) ? "-" : articleWos),
      ((articleGaruda.isEmpty) ? "-" : articleGaruda),
    ];

    String citationScopus = affiliations.scopus?.totalCitation ?? "-";
    String citationScholar = affiliations.google?.totalCitation ?? "-";
    String citationWos = affiliations.wos?.totalCitation ?? "-";
    String citationGaruda = affiliations.garuda?.totalCitation ?? "-";
    List<String> citation = [
      ((citationScopus.isEmpty) ? "-" : citationScopus),
      ((citationScholar.isEmpty) ? "-" : citationScholar),
      ((citationWos.isEmpty) ? "-" : citationWos),
      ((citationGaruda.isEmpty) ? "-" : citationGaruda),
    ];

    String citedScopus = affiliations.scopus?.totalCitedDocument ?? "-";
    String citedScholar = affiliations.google?.totalCitedDocument ?? "-";
    String citedWos = affiliations.wos?.totalCitedDocument ?? "-";
    String citedGaruda = affiliations.garuda?.totalCitedDocument ?? "-";
    List<String> cited = [
      ((citedScopus.isEmpty) ? "-" : citedScopus),
      ((citedScholar.isEmpty) ? "-" : citedScholar),
      ((citedWos.isEmpty) ? "-" : citedWos),
      ((citedGaruda.isEmpty) ? "-" : citedGaruda),
    ];

    //scopus/scholar/wos/garuda
    //article/citation/cited
    List<List<String>> tables = [article, citation, cited];
    return tables;
  }
}
