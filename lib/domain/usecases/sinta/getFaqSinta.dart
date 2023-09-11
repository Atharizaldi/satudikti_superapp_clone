import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetFaqSinta {
  final SintaRepository repository;

  GetFaqSinta(this.repository);

  Future<Either<Failure, FAQList>> execute() {
    return repository.getFaq();
  }
}