import 'package:app/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../data/source/remote/model/tracer/TracerKuesioner.dart';
import '../../repositories/tracerKuesionerRepository.dart';

class GetQuestions {
  final KuesionerTracerRepository repository;

  GetQuestions(this.repository);

  Future<Either<Failure, List<Question>>> execute(int page) {
    return repository.getQuestions(page);
  }
}
