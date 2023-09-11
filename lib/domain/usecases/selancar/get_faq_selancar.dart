import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/selancar_repository.dart';
import 'package:dartz/dartz.dart';

class GetFAQSelancar {
  final SelancarRepository repository;

  GetFAQSelancar(this.repository);

  Future<Either<Failure, FAQList>> execute() {
    return repository.getFAQSelancar();
  }
}
