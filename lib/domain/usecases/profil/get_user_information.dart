import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/profil/user_information.dart';
import 'package:app/domain/repositories/sso_repository.dart';
import 'package:app/presentation/pages/profil/sso/package/credentials.dart';
import 'package:dartz/dartz.dart';

class GetUserInformation {
  final SSORepository repository;

  GetUserInformation(this.repository);

  Future<Either<Failure, UserInformationResponse>> execute(
      Credentials credentials) {
    return repository.getUserInformation(credentials);
  }
}
