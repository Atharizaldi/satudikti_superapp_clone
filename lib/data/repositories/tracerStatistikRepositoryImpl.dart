import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/TracerPie.dart';
import 'package:app/data/source/remote/model/tracer/TracerTable.dart';
import 'package:app/domain/repositories/tracerStatistikRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class StatistikTracerRepositoryImpl implements StatistikTracerRepository {
  final http.Client client;

  StatistikTracerRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, TracerPie>> getHorizontalPieChart(
      String kodePt) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/statistik/keselarasan/pie/$kodePt");
    print('uri $uri');

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        print(TracerPie.fromJson(jsonData));

        return Right(TracerPie.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, TracerPie>> getVerticalPieChart(String kodePt) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/statistik/ketinggian/pie/$kodePt");
    print('uri $uri');

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        print(TracerPie.fromJson(jsonData));

        return Right(TracerPie.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, TracerPie>> getPekerjaanDibawahEnamBulanPieChart(
      String kodePt) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/statistik/pekerjaan/pie/$kodePt");
    print('uri $uri');

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        print(TracerPie.fromJson(jsonData));

        return Right(TracerPie.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, TracerTable>> getHorizontalTable(String kodePt) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/statistik/keselarasan/bar/$kodePt");
    print('uri $uri');

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        print(TracerTable.fromJson(jsonData));

        return Right(TracerTable.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, TracerTable>> getVerticalTable(String kodePt) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/statistik/ketinggian/bar/$kodePt");
    print('uri $uri');

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        print(TracerTable.fromJson(jsonData));

        return Right(TracerTable.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, TracerTable>> getPekerjaanTable(String kodePt) async {
    var uri = Uri.parse("$urlAPI/v2/tracer/statistik/pekerjaan/bar/$kodePt");
    print('uri $uri');

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        print(TracerTable.fromJson(jsonData));

        return Right(TracerTable.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }
}
