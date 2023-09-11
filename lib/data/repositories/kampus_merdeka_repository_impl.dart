import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/MBKMList.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/ckm_list.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/detail_ckm.dart';
import 'package:app/domain/repositories/kampusMerdekaRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class KampusMerdekaRepositoryImpl implements KampusMerdekaRepository {
  final http.Client client;

  KampusMerdekaRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, MBKMList>> getMBKMApi() async {
    var uri = Uri.parse("https://devsuperapp-api.dikti.go.id/v2/mbkm/program");
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(MBKMList.fromJson(jsonData));
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
  Future<Either<Failure, CeritaKampusMerdeka>> getCKM(String category) async {
    var uri = Uri.parse('$urlAPI/v2/mbkm/cerita/$category');
    print("============= BERHASIL MASUK SINI  =============");
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(CeritaKampusMerdeka.fromJson(jsonData));
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
  Future<Either<Failure, DetailCeritaKampusMerdeka>> getDetailCKM(
      String id) async {
    var uri = Uri.parse('$urlAPI/v2/mbkm/cerita/detail/$id');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(DetailCeritaKampusMerdeka.fromJson(jsonData));
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
