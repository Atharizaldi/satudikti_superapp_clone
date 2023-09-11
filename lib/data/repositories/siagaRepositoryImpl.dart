import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/data/source/remote/model/siaga/detailTrackingUsulan.dart';
import 'package:app/data/source/remote/model/siaga/searchTracking.dart';
import 'package:app/domain/repositories/siagaRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class SiagaRepositoryImpl implements SiagaRepository {
  final http.Client client;

  SiagaRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, FAQList>> getFaqSiaga() async {
    var uri = Uri.parse('$urlStagging/faq?module_code=silemkerma');
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

  Future<Either<Failure, StatusPengajuanUsulan>> getDetailTrackingUsulan(
      String kataKunci) async {
    var uri = Uri.parse('$urlStagging/siaga/tracking/$kataKunci');
    print(uri);
    var response = await http.get(uri, headers: appHeaders);

    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(StatusPengajuanUsulan.fromJson(jsonData));
    } else if (response.statusCode == 500) {
      return Left(ServerFailure('error500'));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, SearchTrackingUsulan>> getSearchTrackingUsulan(
      String keyword) async {
    var uri = Uri.parse('$urlStagging/siaga/search-tracking?q=$keyword');
    print(uri);
    try {
      var response = await client
          .get(uri, headers: appHeaders)
          .timeout(const Duration(milliseconds: 3000), onTimeout: () {
        throw SocketException('');
      });
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(SearchTrackingUsulan.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }
}
