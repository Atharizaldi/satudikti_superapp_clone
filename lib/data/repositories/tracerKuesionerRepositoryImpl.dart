import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/AnswerKuesioner.dart';
import 'package:app/data/source/remote/model/tracer/getAllAnswer.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListKabupaten.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListPT.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListProdi.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListProvinsi.dart';
import 'package:app/data/source/remote/model/tracer/postStoreAnswer.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../source/remote/model/tracer/TracerKuesioner.dart';
import '../source/remote/model/tracer/validasiData.dart';

class KuesionerTracerRepositoryImpl implements KuesionerTracerRepository {
  final http.Client client;

  KuesionerTracerRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, List<Question>>> getQuestions(int page) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/questions?page=$page");
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      Logger().d('Response request: ${response.request}');
      Logger().d('Response headers: ${response.headers}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        print("INI GET KUESIONERER ${GetKuesioner.fromJson(jsonData)}");

        return Right(GetKuesioner.fromJson(jsonData).data);
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, ValidasiData>> validateData(String kodePt,
      String kodeProdi, String nim, String tglLahir, String nik) async {
    var uri = Uri.parse("$urlAPI/v3/tracer/validasi");
    try {
      // var response = await client.put(uri, headers: appHeaders);
      Map<String, dynamic> requestData = {
        "kodeprodi": kodeProdi,
        "kodept": kodePt,
        "nik": nik,
        "nim": nim,
        "tgl_lahir": tglLahir
      };
      String jsonPayload = jsonEncode(requestData);
      Logger().d('Json Gived: $jsonPayload');

      final response = await http.post(uri,
          headers: <String, String>{
            dotenv.get('API_KEY'): dotenv.get('API_VALUE'),
            'Content-Type': 'application/json',
          },
          body: jsonPayload);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      Logger().d('Response request: ${response.request}');
      Logger().d('Response headers: ${response.headers}');
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 400) {
        // Extract answers and questions from the response data

        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(ValidasiData.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, GetTracerListProvinsi>> getTracerListProvinsiSearch(
      String keyword) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/provinsi?search=$keyword");
    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        print(GetTracerListProvinsi.fromJson(jsonData));

        return Right(GetTracerListProvinsi.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>>
      getListElasticProvinsitracer() async {
    var uri = Uri.parse('$urlAPI/v2/tracer/provinsi');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getListElasticProvinsi: ${response.statusCode}");
    Map<String, String> provinsiMap = {};
    try {
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        var data = GetTracerListProvinsi.fromJson(jsonData);

        for (int i = 0; i < data.data.length; i++) {
          provinsiMap[data.data[i].namaProvinsi] = data.data[i].kodeProvinsi;
        }

        return Right(provinsiMap);
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<Kabupaten>>> getListElasticKabupatenTracer(
      String kodeProvinsi) async {
    var uri =
        Uri.parse("$urlAPI/v2/tracer/kabupaten?kode_provinsi=$kodeProvinsi");
    try {
      var response = await client.get(uri, headers: appHeaders);
      List<Kabupaten> listData = [];
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        var data = GetTracerListKabupaten.fromJson(jsonData);
        listData = data.data;

        return Right(listData);
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<DataPtTracer>>> getTracerListPt(
      String keyword) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/perguruan_tinggi/$keyword");
    try {
      var response = await client.get(uri, headers: appHeaders);
      List<DataPtTracer> listData = [];
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        var data = GetTracerListPT.fromJson(jsonData);
        listData = data.data;

        return Right(listData);
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<DataProdiTracer>>> getTracerListProdi(
      String kodePt, String keyword) async {
    var uri =
        Uri.parse("$urlAPI/v2/tracer/prodi?kode_pt=$kodePt&search=$keyword");
    try {
      var response = await client.get(uri, headers: appHeaders);
      List<DataProdiTracer> listData = [];
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        var data = GetTracerListProdi.fromJson(jsonData);
        listData = data.data;
        return Right(listData);
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, GetAllAnswer>> getAllAnswer(String id) async {
    var uri = Uri.parse('$urlAPI/v2/tracer/answers/$id');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(GetAllAnswer.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PostStoreAnswerData>> postStoreAnswer(
      List<AnswerKuesioner> listAnswer) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/answers");
    // var uri = Uri.parse("$urlLocal/tracer/answers");

    try {
      var requestBody = jsonEncode(listAnswer
          .map((e) => AnswerKuesioner(
                alumniId: e.alumniId,
                questionId: e.questionId,
                answer: e.answer,
                extraAnswer: e.extraAnswer,
              ))
          .toList());

      print(requestBody);

      final response = await http.post(uri,
          headers: <String, String>{
            dotenv.get('API_KEY'): dotenv.get('API_VALUE'),
            'Content-Type': 'application/json',
          },
          body: requestBody);

      // for (var i = 0; i < listAnswer.length; i++) {
      //   Logger().i(
      //       "INI RESULT DARI IMPL index ke $i ${listAnswer[i].questionId} + ${listAnswer[i].extraAnswer}");
      // }
      // print(jsonEncode(listAnswer
      //     .map((e) => AnswerKuesioner(
      //           alumniId: e.alumniId,
      //           questionId: e.questionId,
      //           answer: e.answer,
      //           extraAnswer: e.extraAnswer,
      //         ))
      //     .toList()));
      print(response.statusCode);
      print("INI LIST JAWABAN ${listAnswer[12].answer}");
      print("INI RESPOSNE BODY ${response.body}");
      print("INI RESPOSNE Header ${response.headers}");
      print("INI RESPOSNE Request ${response.request}");
      print("INI RESPOSNE Status Code ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 422) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        var data = PostStoreAnswerData.fromJson(jsonData);

        return Right(data);
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ServerFailure(''));
    }
  }
}
