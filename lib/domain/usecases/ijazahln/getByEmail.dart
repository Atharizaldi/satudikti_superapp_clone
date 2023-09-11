import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/IjazahLN/status/statusByEmail.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:dartz/dartz.dart';

class GetByEmail {
  final IjazahLnRepository repository;

  GetByEmail(this.repository);

  Future<Either<Failure, StatusByEmail>> execute(
String port, String keyword) {
    return repository.getByEmail(port, keyword);
  }
}
