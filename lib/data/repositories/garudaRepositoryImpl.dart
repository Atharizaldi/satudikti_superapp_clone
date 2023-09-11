import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/data/source/remote/model/garuda/garudaPaper.dart';
import 'package:app/data/source/remote/model/garuda/statistikGaruda.dart';
import 'package:app/domain/repositories/garudaRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class GarudaRepositoryImpl implements GarudaRepository {
  final http.Client client;

  GarudaRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, Garuda>> getListJournal(int page) async {
    var uri =
        Uri.parse("$urlStagging/garuda/journals?access=public&page=$page");
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(Garuda.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, GarudaPaper>> searchGarudaPaper(
      String keyword, int page) async {
    var uri = Uri.parse(
        "$urlStagging/garuda/documents?title=$keyword?access=public&page=$page");
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GarudaPaper.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, Garuda>> searchGarudaJournal(
      String keyword, int page) async {
    var uri = Uri.parse(
        "$urlStagging/garuda/journals?q=$keyword&access=public&page=$page");
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(Garuda.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, Garuda>> searchGarudaJournalBySubject(
      String id, String keyword, int page) async {
    var uri = Uri.parse(
        "$urlStagging/garuda/journals/subject/$id?q=$keyword&page=$page");
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(Garuda.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, ModelStatistikGaruda>> listStatistikGaruda() async {
    var uri = Uri.parse("$urlStagging/tableau?module_name=garuda");
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(ModelStatistikGaruda.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
