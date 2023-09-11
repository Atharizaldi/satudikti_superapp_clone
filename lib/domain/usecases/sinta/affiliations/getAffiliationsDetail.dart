import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsDetail.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetAffiliationsDetail {
  final SintaRepository repository;

  GetAffiliationsDetail(this.repository);

  Future<Either<Failure, AffiliationsDetail>> execute(String id) {
    return repository.getAffiliationsDetail(id);
  }
}