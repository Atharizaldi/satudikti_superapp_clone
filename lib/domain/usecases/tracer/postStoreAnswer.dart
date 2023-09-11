import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/AnswerKuesioner.dart';
import 'package:app/data/source/remote/model/tracer/postStoreAnswer.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';


class PostStoreAnswer {
  final KuesionerTracerRepository repository;

  PostStoreAnswer(this.repository);

  Future<Either<Failure, PostStoreAnswerData>> execute(List<AnswerKuesioner> listAnswer) {
    return repository.postStoreAnswer(listAnswer);
  }
}
