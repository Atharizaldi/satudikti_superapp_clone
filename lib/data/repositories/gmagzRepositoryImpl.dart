import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/gmagz/downloader_gmagz.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_detail_gmagz.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_gmagz.dart';
import 'package:app/domain/repositories/GMagzRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class GMagzRepositoryImpl implements GMagzRepository {
  final http.Client client;

  GMagzRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, MajalahGMagz>> getMajalah(
      String sort, String judul, String displayby, int page) async {
    // var uri = Uri.parse(
    //     'http://127.0.0.1:8090/v2/gmagz/books?rating=$sort&judul=$judul&display-by=$displayby&page=$page');
    var uri = Uri.parse(
        '$urlAPI/v2/gmagz/books?rating=$sort&judul=$judul&display-by=$displayby&page=$page');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(MajalahGMagz.fromJson(jsonData));
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
  Future<Either<Failure, MajalahDetailGMagz>> getMajalahDetail(
      String id) async {
    // var uri = Uri.parse('http://127.0.0.1:8089/v2/gmagz/books/$id');
    var uri = Uri.parse('$urlAPI/v2/gmagz/books/$id');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(MajalahDetailGMagz.fromJson(jsonData));
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
  Future<Either<Failure, DownloaderGMagz>> putDownloader(String id) async {
    var uri = Uri.parse('$urlAPI/v2/gmagz/books/$id/download');
    print(uri);
    try {
      var response = await client.put(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(DownloaderGMagz.fromJson(jsonData));
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
  Future<Either<Failure, DownloaderGMagz>> putReader(String id) async {
    var uri = Uri.parse('$urlAPI/v2/gmagz/books/$id/read');
    print(uri);
    try {
      var response = await client.put(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(DownloaderGMagz.fromJson(jsonData));
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
