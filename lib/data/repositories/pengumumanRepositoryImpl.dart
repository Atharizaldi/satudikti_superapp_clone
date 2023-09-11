import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanDetail.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/domain/repositories/pengumumanRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class PengumumanRepositoryImpl implements PengumumanRepository {
  final http.Client client;

  PengumumanRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, PengumumanList>> getPengumuman(
      String page, String limit) async {
    var uri = Uri.parse('$urlProd/pengumuman?&page=$page&limit=$limit');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getPengumuman : ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(PengumumanList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PengumumanList>> getPengumumanWithCategory(
      String page, String limit, String kategori) async {
    var uri = Uri.parse(
        '$urlProd/pengumuman?&page=$page&limit=$limit&category_id=$kategori');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getPengumumanWithCategory : ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(PengumumanList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PengumumanDetail>> getPengumumanDetail(
      String id) async {
    var uri = Uri.parse('$urlProd/pengumuman/$id');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getPengumumanDetail : ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(PengumumanDetail.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PengumumanList>> getPengumumanSearch(
      String title, String page) async {
    var uri = Uri.parse('$urlProd/pengumuman?title=$title&page=$page');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getPengumumanSearch : ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(PengumumanList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
