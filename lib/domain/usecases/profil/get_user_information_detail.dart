import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/domain/repositories/sso_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserInformationDetail {
  final SSORepository repository;

  GetUserInformationDetail(this.repository);

  Future<Either<Failure, UserInformationDetailResponse>> execute(
      String? username) {
    return repository.getUserInformationDetail(username!);
  }
}
