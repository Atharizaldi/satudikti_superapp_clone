import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:dartz/dartz.dart';

abstract class FaqApiRepository {
  Future<Either<Failure, FAQList>> getFAQAPI();
  Future<Either<Failure, FAQList>> getFAQModule(String moduleCode);
  Future<Either<Failure, FAQList>> getFAQSearch(String keyword);
}
