import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAgregatPT.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetAgregatPTAPI {
  PddiktiDetailRepository repository;
  GetAgregatPTAPI(this.repository);

  Future<Either<Failure, GetAgregatPT>> execute(String ptId) {
    return repository.getAgregatPTAPI(ptId);
  }
}
