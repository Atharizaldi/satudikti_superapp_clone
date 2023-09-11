import 'dart:convert';

import 'package:app/data/source/remote/model/config.dart';
import 'package:app/domain/repositories/configRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../common/baseUrl.dart';
import '../../common/failure.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final http.Client client;

  ConfigRepositoryImpl({required this.client});
//a
  @override
  Future<Either<Failure, Config>> getConfigValue(int moduleId) async {
    var uri = Uri.parse("$urlAPI/v2/modul/config/$moduleId");
    print(uri);
    var response = await client.get(uri, headers: appHeaders);

    Logger().i("GET CONFIG: ${response.statusCode}");
    Logger().i(response.body);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);

      return Right(Config.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
