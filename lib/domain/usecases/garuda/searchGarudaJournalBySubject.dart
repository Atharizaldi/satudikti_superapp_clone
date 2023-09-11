import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/domain/repositories/garudaRepository.dart';
import 'package:dartz/dartz.dart';

class SearchGarudaJournalBySubject {
  final GarudaRepository repository;

  SearchGarudaJournalBySubject(this.repository);

  Future<Either<Failure, Garuda>> execute(String keyword, String id, int page) {
    return repository.searchGarudaJournalBySubject(keyword, id, page);
  }
}
