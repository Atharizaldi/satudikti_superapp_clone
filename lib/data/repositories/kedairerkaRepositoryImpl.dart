import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kedaireka/kedairekaList.dart';
import 'package:app/domain/repositories/kedairekaRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class KedairekaRepositoryImpl implements KedairekaRepository {
  final http.Client client;

  KedairekaRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, ModelKedairekaIndustri>> getListKedaireka(
      String limit) async {
    var uri = Uri.parse(
        'https://api.kedaireka.id/public/business_case/featured?limit=$limit');
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(ModelKedairekaIndustri.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, ModelKedairekaIndustri>> getListKedairekaPT(
      String limit) async {
    var uri = Uri.parse(
        'https://api.kedaireka.id/public/innovation/featured?limit=$limit');
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(ModelKedairekaIndustri.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
