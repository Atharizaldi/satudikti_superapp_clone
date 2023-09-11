import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/berita/newsDetail.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/domain/repositories/beritaRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BeritaRepositoryImpl implements BeritaRepository {
  final http.Client client;

  BeritaRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, NewsList>> getNews(
      String categoryId, String page, String limit) async {
    var uri = Uri.parse(
        '$urlProd/news?category_id=$categoryId&page=$page&limit=$limit');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getNews : ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(NewsList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, NewsDetail>> getNewsDetail(String id) async {
    var uri = Uri.parse('$urlProd/news/$id');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getNewsDetail : ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(NewsDetail.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, NewsList>> getNewsSearch(
      String title, String page) async {
    var uri = Uri.parse('$urlProd/news?title=$title&page=$page');
    var response = await http.get(uri, headers: appHeaders);
    Logger().i("getNewsSearch : ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(NewsList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
