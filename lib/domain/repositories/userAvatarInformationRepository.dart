

import 'dart:io';

import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/profil/user_avatar_information.dart';
import 'package:dartz/dartz.dart';

abstract class UserAvatarInformationRepository{

  Future<Either<Failure, UserAvatarInformation>> getUserAvatar (String userId);

  Future<Either<Failure, UserAvatarInformation>> putUserAvatar (File avatar, String userId);
}