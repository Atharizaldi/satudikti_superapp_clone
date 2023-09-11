import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/data/source/remote/model/selancar/profile_PAK_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:app/domain/repositories/selancar_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class SelancarRepositoryImpl implements SelancarRepository {
  final http.Client client;

  SelancarRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, FAQList>> getFAQSelancar() async {
    var uri = Uri.parse('$urlStagging/faq?module_code=pak-dosen');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(FAQList.fromJson(jsonData));
    } else if (response.statusCode == 500) {
      return Left(ServerFailure('error500'));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, ProfilePAKDetail>> getProfileDetail(
      String nidn) async {
    var uri = Uri.parse('$urlStagging/selancar-pak/profile/$nidn');
    print(uri);
    try {
      var response = await client
          .get(uri, headers: appHeaders)
          .timeout(const Duration(milliseconds: 3000), onTimeout: () {
        throw SocketException('');
      });
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(ProfilePAKDetail.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, UsulanList>> getUsulanList(String nidn) async {
    var uri = Uri.parse('$urlStagging/selancar-pak/profile/$nidn/riwayat');
    print(uri);
    try {
      var response = await client
          .get(uri, headers: appHeaders)
          .timeout(const Duration(milliseconds: 3000), onTimeout: () {
        throw SocketException('');
      });
      Logger().d('usulan respcode: ${response.statusCode}');
      Logger().d('Response usulan: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(UsulanList.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, UsulanDetail>> getUsulanDetail(
      String nidn, String id) async {
    var uri =
        Uri.parse('$urlStagging/selancar-pak/v2/profile/$nidn/riwayat/$id');
    print(uri);
    try {
      var response = await client
          .get(uri, headers: appHeaders)
          .timeout(const Duration(milliseconds: 3000), onTimeout: () {
        throw SocketException('');
      });
      Logger().d('detail respcode: ${response.statusCode}');
      Logger().d('Response detail: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(UsulanDetail.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }
}
