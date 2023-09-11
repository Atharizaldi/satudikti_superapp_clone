import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsDetail.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsList.dart';
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsScopus.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsDetail.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsList.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsScopus.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsDetail.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsList.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsScholar.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class SintaRepositoryImpl implements SintaRepository {
  final http.Client client;

  SintaRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, FAQList>> getFaq() async {
    var uri = Uri.parse('$urlStagging/faq?module_code=sinta');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getFaq status: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(FAQList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AuthorsList>> getAuthorsList(
      int items, int page, int order, String q) async {
    var uri = Uri.parse(
        '$urlLocal/sinta/authors?items=$items&page=$page&order=$order&q=$q');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getAuthorsList status: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(AuthorsList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AuthorsDetail>> getAuthorsDetail(String nidn) async {
    var uri = Uri.parse('$urlStagging/sinta/authors/$nidn');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getAuthorsDetail status: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(AuthorsDetail.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AuthorsScopus>> getAuthorsScopus(
      String nidn, int items, int page, int order) async {
    var uri = Uri.parse(
        '$urlStagging/sinta/authors/$nidn/scopus?items=$items&page=$page&order=$order');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getAuthorsScopus status: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(AuthorsScopus.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AffiliationsList>> getAffiliationsList(
      int items, int page, int order, String q) async {
    var uri = Uri.parse(
        '$urlLocal/sinta/affiliations?items=$items&page=$page&order=$order&q=$q');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getAffiliationsList status: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(AffiliationsList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AffiliationsDetail>> getAffiliationsDetail(
      String id) async {
    var uri = Uri.parse('$urlStagging/sinta/affiliations/$id');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getAffiliationsDetail status: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(AffiliationsDetail.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AffiliationsScopus>> getAffiliationsScopus(
      String id, int items, int page, int order) async {
    var uri = Uri.parse(
        '$urlStagging/sinta/affiliations/$id/scopus?items=$items&page=$page&order=$order');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getAffiliationsScopus status: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(AffiliationsScopus.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, JournalsList>> getJournalsList(
      int items, int page, int order, String q) async {
    var uri = Uri.parse(
        '$urlStagging/sinta/journals?items=$items&page=$page&order=$order&q=$q');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getJournalsList status: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(JournalsList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, JournalsDetail>> getJournalsDetail(String id) async {
    var uri = Uri.parse('$urlStagging/sinta/journals/$id');
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      Logger().i("getJournalsDetail status: ${response.statusCode}");
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(JournalsDetail.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, JournalsScholar>> getJournalsScholar(
      String id, int items, int page, int order) async {
    var uri = Uri.parse(
        '$urlStagging/sinta/journals/$id/google?items=$items&page=$page&order=$order');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      Logger().i("getJournalsScholar status: ${response.statusCode}");
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(JournalsScholar.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
