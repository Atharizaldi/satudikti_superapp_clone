import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/data/source/remote/model/profil/user_information.dart';
import 'package:app/domain/repositories/sso_repository.dart';
import 'package:app/presentation/pages/profil/sso/package/credentials.dart';
import 'package:app/presentation/pages/profil/sso/utils/sso_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class SSORepositoryImpl extends SSORepository {
  final http.Client client;

  SSORepositoryImpl({required this.client});

  @override
  Future<Either<Failure, UserInformationResponse>> getUserInformation(
      Credentials credentials) async {
    var uri = Uri.parse(urlUserinfo);

    Map<String, String> headers = {
      'Authorization': 'Bearer ${credentials.accessToken}',
    };
    print("URI SSO: $uri headers: $headers");

    try {
      var response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        Logger().e(jsonData);
        return Right(UserInformationResponse.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, UserInformationDetailResponse>>
      getUserInformationDetail(String username) async {
    var uri = Uri.parse('$urlStagging/sso/api/v1/user/profile/$username');

    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().i("INI RESPONSE HEADER ${response.headers}");
      Logger().i("INI RESPONSE BODY ${response.body}");
      Logger().i("INI RESPONSE REQUEST ${response.request}");

      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(UserInformationDetailResponse.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, void>> logoutSSO() async {
    var uri = Uri.parse(urlLogoutSSO);

    try {
      var response = await client.get(uri, headers: appHeaders);

      print("LOGOUTSSO ${response.statusCode}");
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }
}
