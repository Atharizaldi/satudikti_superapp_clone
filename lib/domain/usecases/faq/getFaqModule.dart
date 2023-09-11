import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/faqApiRepository.dart';
import 'package:dartz/dartz.dart';

class GetFaqModule {
  final FaqApiRepository repository;

  GetFaqModule(this.repository);

  Future<Either<Failure, FAQList>> execute(String moduleCode) {
    return repository.getFAQModule(moduleCode);
  }
}
