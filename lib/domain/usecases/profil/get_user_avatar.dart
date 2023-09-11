
import 'package:app/data/source/remote/model/profil/user_avatar_information.dart';
import 'package:app/domain/repositories/userAvatarInformationRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';

class GetUserAvatar {
  final UserAvatarInformationRepository repository;

  GetUserAvatar(this.repository);

  Future<Either<Failure, UserAvatarInformation>> execute(
      String? userId) {
    return repository.getUserAvatar(userId!);
  }
}