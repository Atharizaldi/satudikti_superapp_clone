import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/data/source/remote/model/profil/user_information.dart';
import 'package:app/presentation/pages/profil/sso/package/credentials.dart';
import 'package:dartz/dartz.dart';

abstract class SSORepository {
  Future<Either<Failure, UserInformationResponse>> getUserInformation(
      Credentials credentials);

  Future<Either<Failure, UserInformationDetailResponse>>
      getUserInformationDetail(String username);

  Future<Either<Failure, void>> logoutSSO();
}
