import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsScopus.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetAuthorsScopus {
  final SintaRepository repository;

  GetAuthorsScopus(this.repository);

  Future<Either<Failure, AuthorsScopus>> execute(String nidn, int items, int page, int order) {
    return repository.getAuthorsScopus(nidn, items, page, order);
  }
}