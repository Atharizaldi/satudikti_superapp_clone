import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/berita/newsDetail.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:dartz/dartz.dart';

abstract class BeritaRepository {
  Future<Either<Failure, NewsList>> getNews(
      String categoryId, String page, String limit);
  Future<Either<Failure, NewsDetail>> getNewsDetail(String id);
  Future<Either<Failure, NewsList>> getNewsSearch(String title, String page);
}
