import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/berita/newsDetail.dart';
import 'package:app/domain/repositories/beritaRepository.dart';
import 'package:dartz/dartz.dart';

class GetNewsDetail {
  final BeritaRepository repository;

  GetNewsDetail(this.repository);

  Future<Either<Failure, NewsDetail>> execute(String id) {
    return repository.getNewsDetail(id);
  }
}
