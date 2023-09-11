import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tableau.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetStatistic {
  PddiktiRepository repository;
  GetStatistic(this.repository);

  Future<Either<Failure, Tableau>> execute() {
    return repository.getStatistic();
  }
}
