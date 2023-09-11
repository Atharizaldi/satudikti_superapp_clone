import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/getAllAnswer.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';

class GetAllAnswersTracer {
  final KuesionerTracerRepository repository;

  GetAllAnswersTracer(this.repository);

  Future<Either<Failure, GetAllAnswer>> execute(String id) {
    return repository.getAllAnswer(id);
  }
}
