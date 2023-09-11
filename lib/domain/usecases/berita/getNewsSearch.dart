import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/domain/repositories/beritaRepository.dart';
import 'package:dartz/dartz.dart';

class GetNewsSearch {
  final BeritaRepository repository;

  GetNewsSearch(this.repository);

  Future<Either<Failure, NewsList>> execute(String keyword) {
    return repository.getNewsSearch(keyword, '1');
  }
}
