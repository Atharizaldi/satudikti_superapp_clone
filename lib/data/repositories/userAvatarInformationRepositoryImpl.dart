import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/profil/user_avatar_information.dart';
import 'package:app/domain/repositories/userAvatarInformationRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

class UserAvatarInformationRepositoryImpl
    implements UserAvatarInformationRepository {
  final http.Client client;

  UserAvatarInformationRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, UserAvatarInformation>> getUserAvatar(
      String userId) async {
    var uri =
        Uri.parse("${urlStagging}/sso/api/v1/user/profile/${userId}/avatar");

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        Logger().i("getAvatar status: ${response.statusCode}");
        var data = jsonDecode(response.body.toString());
        return Right(UserAvatarInformation.fromJson(data));
      } else {
        return Left(ServerFailure(''));
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserAvatarInformation>> putUserAvatar(
      File avatar, String userId) async {
    var uri =
        Uri.parse("${urlStagging}/sso/api/v1/user/profile/${userId}/avatar");
    var data;

    try {
      var req = http.MultipartRequest("PUT", uri);
      req.headers.addAll(appHeaders);
      var multiPartFile = await http.MultipartFile.fromPath(
          "avatar", avatar.path,
          contentType: MediaType('image', 'jpg'));
      req.files.add(multiPartFile);

      await req.send().then((response) async {
        response.stream.transform(utf8.decoder).listen((value) {
          data = json.decode(value);
          print(data.toString());
        });
      });
      return Right(UserAvatarInformation.fromJson(data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Future<Either<Failure, UserAvatarInformation>> putUserAvatar(File avatar, String userId) async{
  //   // TODO: implement putUserAvatar
  //   var uri = Uri.parse("${urlStagging}/sso/api/v1/user/profile/${userId}/avatar");

  //   try{
  //     var req = http.MultipartRequest("PUT", uri);
  //     req.headers.addAll(appHeaders);
  //     var multiPartFile = await http.MultipartFile.fromPath("avatar", avatar.path, contentType: MediaType('image', 'jpg'));
  //     req.files.add(multiPartFile);

  //     await req.send().then((response) async{
  //       response.stream.transform(utf8.decoder).listen((value) {
  //         var data = json.decode(value);
  //         print(data.toString());
  //         return Right(UserAvatarInformation.fromJson(data));
  //       });
  //     });

  //   }catch(e){
  //     print(e);
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }

}
