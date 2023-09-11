import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/domain/repositories/beritaRepository.dart';
import 'package:dartz/dartz.dart';

class GetNews {
  final BeritaRepository repository;

  GetNews(this.repository);

  Future<Either<Failure, NewsList>> execute(String categoryId, String page, String limit) {
    return repository.getNews(categoryId, page, limit);
  }
}
