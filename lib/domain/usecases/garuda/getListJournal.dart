import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/domain/repositories/garudaRepository.dart';
import 'package:dartz/dartz.dart';

class GetListJournal {
  final GarudaRepository repository;

  GetListJournal(this.repository);

  Future<Either<Failure, Garuda>> execute(int page) {
    return repository.getListJournal(page);
  }
}
