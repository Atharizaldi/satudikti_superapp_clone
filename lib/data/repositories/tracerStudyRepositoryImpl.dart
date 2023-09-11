import 'dart:convert';

import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/tracerStudyRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../common/baseUrl.dart';
import '../../common/failure.dart';

class TracerStudyRepositoryImpl implements TracerStudyRepository {
  final http.Client client;

  TracerStudyRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, FAQList>> getFaq() async {
    var uri = Uri.parse('http://34.172.238.24:8089/v2/faq?module_code=tracer');
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
}
