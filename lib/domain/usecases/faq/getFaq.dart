import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/faqApiRepository.dart';
import 'package:dartz/dartz.dart';

class GetFaq {
  final FaqApiRepository repository;

  GetFaq(this.repository);

  Future<Either<Failure, FAQList>> execute() {
    return repository.getFAQAPI();
  }
}
