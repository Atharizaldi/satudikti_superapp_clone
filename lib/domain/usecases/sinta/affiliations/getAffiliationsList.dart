import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsList.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetAffiliationsList {
  final SintaRepository repository;

  GetAffiliationsList(this.repository);

  Future<Either<Failure, AffiliationsList>> execute(int items, int page, int order, String q) {
    return repository.getAffiliationsList(items, page, order, q);
  }
}