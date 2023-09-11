import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsDetail.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetAuthorsDetail {
  final SintaRepository repository;

  GetAuthorsDetail(this.repository);

  Future<Either<Failure, AuthorsDetail>> execute(String nidn) {
    return repository.getAuthorsDetail(nidn);
  }
}
