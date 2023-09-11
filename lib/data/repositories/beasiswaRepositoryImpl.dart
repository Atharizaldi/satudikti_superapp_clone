import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:app/domain/repositories/beasiswaRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class BeasiswaRepositoryImpl implements BeasiswaRepository {
  final http.Client client;

  BeasiswaRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, Beasiswa>> getListBeasiswaSedangDibuka(
      int page) async {
    var uri = Uri.parse(
        "$urlSementaraBeasiswa/beasiswa?status=Sedang Dibuka&page=$page");
    print('uri $uri');

    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(Beasiswa.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, Beasiswa>> getListBeasiswaSedangDitutup(
      int page) async {
    var uri = Uri.parse(
        "$urlSementaraBeasiswa/beasiswa?status=Sudah Ditutup&page=$page");
    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(Beasiswa.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, Beasiswa>> getListBeasiswaAkanDibuka(int page) async {
    var uri = Uri.parse(
        "$urlSementaraBeasiswa/beasiswa?status=Akan Dibuka&page=$page");
    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(Beasiswa.fromJson(jsonData));
      } else {
        return Left(ServerFailure('internalServer500'));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, Beasiswa>> searchListBeasiswa(
      String keyword, int page) async {
    var uri =
        Uri.parse("$urlSementaraBeasiswa/beasiswa?nama=$keyword&page=$page");
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(Beasiswa.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, Beasiswa>> searchListBeasiswaClosed(
      String keyword, int page) async {
    var uri = Uri.parse(
        "$urlSementaraBeasiswa/beasiswa?nama=$keyword&status=Sudah Ditutup&page=$page");
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(Beasiswa.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, Beasiswa>> searchListBeasiswaFilter(
      String keyword, int page, int penerima) async {
    var uri = Uri.parse(
        "$urlSementaraBeasiswa/beasiswa?nama=$keyword&page=$page&penerima=$penerima");
    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(Beasiswa.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }
}
