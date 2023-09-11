import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/modul.dart';
import 'package:app/domain/repositories/modulRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ModulRepositoryImpl implements ModulRepository {
  final http.Client client;

  ModulRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, AutoGenerate>> getModulSearch(String keyword) async {
    try {
      var uri;
      var encodedKeyword = Uri.encodeComponent(keyword);
      print("EncodedKeyword $encodedKeyword");
      if (keyword == "tracer" ||
          keyword == "study" ||
          keyword == "tracer study" ||
          keyword == "study tracer") {
        uri = Uri.parse('$urlLocal/modul?keyword=$encodedKeyword');
      } else {
        uri = Uri.parse('$urlStagging/modul?keyword=$encodedKeyword');
      }
      print(uri);
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        // var hasilSearchModul = AutoGenerate.fromJson(jsonData);
        // for (int i = 0; i < hasilSearchModul.data.modul.length; i++) {
        //   listModul.add(hasilSearchModul.data.modul[i].moduleName);
        // }
        return Right(AutoGenerate.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } catch (e) {
      return Left(ServerFailure(''));
    }
  }
}
