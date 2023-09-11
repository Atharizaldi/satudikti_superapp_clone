import 'package:app/common/failure.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetListElasticProvinsi {
  PddiktiRepository repository;
  GetListElasticProvinsi(this.repository);

  Future<Either<Failure, Map<String, String>>> execute() {
    return repository.getListElasticProvinsi();
  }
}
