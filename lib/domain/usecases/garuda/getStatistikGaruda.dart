import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/garuda/statistikGaruda.dart';
import 'package:app/domain/repositories/garudaRepository.dart';
import 'package:dartz/dartz.dart';

class GetListStatistikGaruda {
  final GarudaRepository repository;

  GetListStatistikGaruda(this.repository);

  Future<Either<Failure, ModelStatistikGaruda>> execute() {
    return repository.listStatistikGaruda();
  }
}
