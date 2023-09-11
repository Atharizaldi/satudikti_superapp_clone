import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListPT.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';

class GetListPtTracer {
  KuesionerTracerRepository repository;

  GetListPtTracer(this.repository);

  Future<Either<Failure, List<DataPtTracer>>> execute(String keyword) {
    return repository.getTracerListPt(keyword);
  }
}
