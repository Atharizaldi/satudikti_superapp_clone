import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/siagaRepository.dart';
import 'package:dartz/dartz.dart';

class GetFaqSiaga {
  final SiagaRepository repository;

  GetFaqSiaga(this.repository);

  Future<Either<Failure, FAQList>> execute() {
    return repository.getFaqSiaga();
  }
}