import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:app/domain/repositories/beasiswaRepository.dart';
import 'package:dartz/dartz.dart';

class SearchListBeasiswa {
  final BeasiswaRepository repository;

  SearchListBeasiswa(this.repository);

  Future<Either<Failure, Beasiswa>> execute(String keyword, int page) {
    return repository.searchListBeasiswa(keyword, page);
  }

  Future<Either<Failure, Beasiswa>> executeClosedFilter(
      String keyword, int page) {
    return repository.searchListBeasiswaClosed(keyword, page);
  }
}
