import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getSpecificElasticPT.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetListElasticPTAPI {
  PddiktiRepository repository;

  GetListElasticPTAPI(this.repository);

  Future<Either<Failure, GetSpecificElasticPT>> execute(String keyword) {
    return repository.getListElasticPTAPI(keyword);
  }
}
