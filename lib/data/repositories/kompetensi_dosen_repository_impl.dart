import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/common/launchUrl.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/daftarUnduhan.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/penilaian_dosen.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/programTerdaftar.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/sertifikat.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/tawaranProgram.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/unduhan.dart';
import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class KompetensiDosenRepositoryImpl extends KompetensiDosenRepository {
  final http.Client client;

  KompetensiDosenRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, TawaranProgramResponse>>
      getListTawaranProgram() async {
    try {
      var uri = Uri.parse("$urlStagging/kompetensi/tawaran/list");
      print("uri $uri");
      final result = await client.get(uri, headers: appHeaders);
      if (result.statusCode == 200) {
        String jsonDataString = result.body.toString();
        Map<String, dynamic> responseBody = jsonDecode(jsonDataString);
        return Right(TawaranProgramResponse.fromJson(responseBody));
      } else if (result.statusCode == 404) {
        return Left(NotFoundFailure(''));
      } else {
        return Left(ServerFailure(""));
      }
    } on SocketException {
      return Left(ConnectionFailure(""));
    }
  }

  @override
  Future<Either<Failure, DaftarUnduhanResponse>> getFileList() async {
    try {
      var uri = Uri.parse("$urlStagging/kompetensi/file/list");
      print("uri $uri");
      final result = await client.get(uri, headers: appHeaders);
      if (result.statusCode == 200) {
        String jsonDataString = result.body.toString();
        Map<String, dynamic> responseBody = jsonDecode(jsonDataString);
        return Right(DaftarUnduhanResponse.fromJson(responseBody));
      } else {
        return Left(ServerFailure(""));
      }
    } on SocketException {
      return Left(ConnectionFailure(""));
    }
  }

  @override
  Future<Either<Failure, PenilaianDosen>> getPenilaianDosen(String id) async {
    try {
      var uri = Uri.parse("$urlStagging/kompetensi/program/penilaian/$id");
      print("uri $uri");
      final result = await client.get(uri, headers: appHeaders);
      print(result.statusCode);
      if (result.statusCode == 200) {
        String jsonDataString = result.body.toString();
        Map<String, dynamic> responseBody = jsonDecode(jsonDataString);
        return Right(PenilaianDosen.fromJson(responseBody));
      } else {
        return Left(ServerFailure(""));
      }
    } on SocketException {
      return Left(ConnectionFailure(""));
    }
  }

  @override
  Future<Either<Failure, Sertifikat>> getSertifikat(String id) async {
    try {
      // var uri = Uri.parse("$urlStagging/kompetensi/sertifikat/$id");
      var uri = Uri.parse(
          "https://kompetensi.sumberdaya.kemdikbud.go.id/web/downloadfile/34");
      print("uri $uri");
      final result = await client.get(uri, headers: appHeaders);
      if (result.statusCode == 200) {
        return Right(Sertifikat.fromJson(result.body));
      } else {
        return Left(ServerFailure(""));
      }
    } on SocketException {
      return Left(ConnectionFailure(""));
    }
  }

  @override
  Future<void> downloadSertifikat(String id) async {
    launchURLWithAppHeaders("$urlStagging/kompetensi/sertifikat/$id");
  }

  @override
  Future<Either<Failure, Unduhan>> getUnduhan(String id) async {
    try {
      var uri = Uri.parse("$urlStagging/kompetensi/file/unduh/$id");
      print("uri $uri");
      final result = await client.get(uri, headers: appHeaders);
      if (result.statusCode == 200) {
        return Right(Unduhan.fromJson(result.body));
      } else {
        return Left(ServerFailure(""));
      }
    } on SocketException {
      return Left(ConnectionFailure(""));
    }
  }

  @override
  Future<void> downloadUnduhan(String id) async {
    launchURLWithAppHeaders("$urlStagging/kompetensi/file/unduh/$id");
  }

  // @override
  // Future<Either<Failure, ProgramTerdaftarResponse>> getProgramTerdaftar(
  //     String nidn, String tahun) async {
  //   var uri =
  //       Uri.parse("$urlDev/kompetensi/program/list/0809048405?tahun=2022");
  //   final result = await client.get(uri);
  //   print(
  //       "uri $uri w/ reuslt $result and statuscode ${result.statusCode} res body ${result.body}");
  //   return Left(ServerFailure(""));
  // }
  @override
  Future<Either<Failure, ProgramTerdaftarResponse>> getProgramTerdaftar(
      String nidn, String tahun) async {
    try {
      var uri =
          Uri.parse("$urlStagging/kompetensi/program/list/$nidn?tahun=$tahun");
      print("uri $uri");
      final result = await client.get(uri, headers: appHeaders);
      print("statuscode ${result.statusCode}");
      if (result.statusCode == 200) {
        String jsonDataString = result.body.toString();
        Map<String, dynamic> responseBody = jsonDecode(jsonDataString);
        return Right(ProgramTerdaftarResponse.fromJson(responseBody));
      } else {
        return Left(ServerFailure(""));
      }
    } on SocketException {
      return Left(ConnectionFailure(""));
    }
  }
}
