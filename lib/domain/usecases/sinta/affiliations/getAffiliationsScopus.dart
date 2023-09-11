import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsScopus.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetAffiliationsScopus {
  final SintaRepository repository;

  GetAffiliationsScopus(this.repository);

  Future<Either<Failure, AffiliationsScopus>> execute(String id, int items, int page, int order) {
    return repository.getAffiliationsScopus(id, items, page, order);
  }
}