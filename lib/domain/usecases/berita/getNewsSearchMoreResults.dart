import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/domain/repositories/beritaRepository.dart';
import 'package:dartz/dartz.dart';

class GetNewsSearchMoreResults {
  final BeritaRepository repository;

  GetNewsSearchMoreResults(this.repository);

  Future<Either<Failure, NewsList>> execute(String keyword, String page) {
    return repository.getNewsSearch(keyword, page);
  }
}
