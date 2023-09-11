import 'package:app/common/failure.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';

class GetListElasticProvinsitracer {
  KuesionerTracerRepository repository;
  GetListElasticProvinsitracer(this.repository);

  Future<Either<Failure, Map<String, String>>> execute() {
    return repository.getListElasticProvinsitracer();
  }
}
