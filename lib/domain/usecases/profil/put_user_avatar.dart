import 'dart:io';

import 'package:app/data/source/remote/model/profil/user_avatar_information.dart';
import 'package:app/domain/repositories/userAvatarInformationRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';

class PutUserAvatar {
  final UserAvatarInformationRepository repository;

  PutUserAvatar(this.repository);

  Future<Either<Failure, UserAvatarInformation>> execute(
      File? avatar, String? userId) {
    return repository.putUserAvatar(avatar!, userId!);
  }
}