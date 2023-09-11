import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/domain/repositories/garudaRepository.dart';
import 'package:dartz/dartz.dart';

class SearchGarudaJournal {
  final GarudaRepository repository;

  SearchGarudaJournal(this.repository);

  Future<Either<Failure, Garuda>> execute(String keyword, int page) {
    return repository.searchGarudaJournal(keyword, page);
  }
}
