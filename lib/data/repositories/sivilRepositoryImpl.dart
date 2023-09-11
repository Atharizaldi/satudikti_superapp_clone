import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListProdi.dart';
import 'package:app/data/source/remote/model/sivil/sivilList.dart';
import 'package:app/domain/repositories/sivilRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class SivilRepositoryImpl extends SivilRepository {
  final http.Client client;

  SivilRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, GetListPT>> getSearchListPT(String keyword) async {
    var uri = Uri.parse('$urlProd/pddikti/perguruan_tinggi?q=$keyword');

    try {
      var response = await client.get(uri, headers: appHeaders);

      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(GetListPT.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, GetListProdi>> getSearchListProdi(
      String idPt, String keyword) async {
    var uri =
        Uri.parse('$urlProd/pddikti/perguruan_tinggi/$idPt/prodi?q=$keyword');

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(GetListProdi.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, Sivil>> getSivil(
      String kodePt, kodeProdi, noIjazah) async {
    var uri = Uri.parse(
        '$urlStagging/sivil/perguruan_tinggi/$kodePt/prodi/$kodeProdi/mahasiswa?no-ijazah=$noIjazah');
    print(uri);
    var response = await http.get(uri, headers: appHeaders);

    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(Sivil.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
