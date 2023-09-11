import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsDetail.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsList.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsScopus.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsDetail.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsList.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsScopus.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsDetail.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsList.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsScholar.dart';
import 'package:dartz/dartz.dart';

abstract class SintaRepository {
  Future<Either<Failure, FAQList>> getFaq();
  Future<Either<Failure, AuthorsList>> getAuthorsList(int items, int page, int order, String q);
  Future<Either<Failure, AuthorsDetail>> getAuthorsDetail(String nidn);
  Future<Either<Failure, AuthorsScopus>> getAuthorsScopus(String nidn, int items, int page, int order);
  Future<Either<Failure, AffiliationsList>> getAffiliationsList(int items, int page, int order, String q);
  Future<Either<Failure, AffiliationsDetail>> getAffiliationsDetail(String id);
  Future<Either<Failure, AffiliationsScopus>> getAffiliationsScopus(String id, int items, int page, int order);
  Future<Either<Failure, JournalsList>> getJournalsList(int items, int page, int order, String q);
  Future<Either<Failure, JournalsDetail>> getJournalsDetail(String id);
  Future<Either<Failure, JournalsScholar>> getJournalsScholar(String id, int items, int page, int order);
}