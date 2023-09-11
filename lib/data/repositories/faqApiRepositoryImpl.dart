import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/faqApiRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class FaqApiRepositoryImpl implements FaqApiRepository {
  // final http.Client client;

  // FaqApiRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, FAQList>> getFAQAPI() async {
    var uri = Uri.parse('$urlAPI/faq?module_code=umum');
    print(uri);
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var response = await http.get(uri, headers: appHeaders);
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(FAQList.fromJson(jsonData));
    } on Exception {
      return Left(ConnectionFailure(''));
    }
  }

  Future<Either<Failure, FAQList>> getFAQModule(String moduleCode) async {
    var uri;
    if (moduleCode == 'tracer' ||
        moduleCode == 'study' ||
        moduleCode == 'tracer study' ||
        moduleCode == 'study tracer') {
      uri = Uri.parse(
          'https://devsuperapp-api.dikti.go.id/v2/faq?module_code=tracer');
    } else {
      uri = Uri.parse('$urlAPI/faq?module_code=$moduleCode');
    }
    print(uri);
    var response = await http.get(uri, headers: appHeaders);
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
  Future<Either<Failure, FAQList>> getFAQSearch(String keyword) async {
    var uri;
    if (keyword == 'tracer' ||
        keyword == 'study' ||
        keyword == 'tracer study' ||
        keyword == 'study tracer') {
      uri = Uri.parse(
          'https://devsuperapp-api.dikti.go.id/v2/faq?keyword=tracer');
    } else {
      uri = Uri.parse('$urlAPI/faq?keyword=$keyword');
    }
    print(uri);
    var response = await http.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(FAQList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
