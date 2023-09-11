import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListKabupaten.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';

class GetListElasticKabupaten {
  KuesionerTracerRepository repository;
  GetListElasticKabupaten(this.repository);

  Future<Either<Failure, List<Kabupaten>>> execute(String kodeProv) {
    return repository.getListElasticKabupatenTracer(kodeProv);
  }
}