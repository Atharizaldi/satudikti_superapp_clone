import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListProdi.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';

class GetListProdiTracer {
  KuesionerTracerRepository repository;
  GetListProdiTracer(this.repository);

  Future<Either<Failure, List<DataProdiTracer>>> execute(String kodePt, String keyword) {
    return repository.getTracerListProdi(kodePt, keyword);
  }
}