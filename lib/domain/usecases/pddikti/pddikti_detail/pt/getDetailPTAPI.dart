import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getDetailPT.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetDetailPTAPI {
  PddiktiDetailRepository repository;
  GetDetailPTAPI(this.repository);

  Future<Either<Failure, GetDetailPT>> execute(String kodePT) {
    return repository.getDetailPTAPI(kodePT);
  }
}
