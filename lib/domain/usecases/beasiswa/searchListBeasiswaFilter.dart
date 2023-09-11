import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:app/domain/repositories/beasiswaRepository.dart';
import 'package:dartz/dartz.dart';

class SearchListBeasiswaFilter {
  final BeasiswaRepository repository;

  SearchListBeasiswaFilter(this.repository);

  Future<Either<Failure, Beasiswa>> execute(
      String keyword, int page, int penerima) {
    return repository.searchListBeasiswaFilter(keyword, page, penerima);
  }
}
