import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsList.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetAuthorsList {
  final SintaRepository repository;

  GetAuthorsList(this.repository);

  Future<Either<Failure, AuthorsList>> execute(int items, int page, int order, String q) {
    return repository.getAuthorsList(items, page, order, q);
  }
}