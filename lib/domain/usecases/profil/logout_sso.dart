import 'package:app/common/failure.dart';
import 'package:app/domain/repositories/sso_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutSSO {
  final SSORepository repository;

  LogoutSSO(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.logoutSSO();
  }
}
