import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/IjazahLN/status/statusByEmail.dart';
import 'package:app/data/source/remote/model/IjazahLN/status/statusByNoRegis.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/negaraIjazahLNList.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/prodiPTLN.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ptIjazahLNList.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ststusSK.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class IjazahLnRepositoryImpl implements IjazahLnRepository {
  final http.Client client;

  IjazahLnRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, FAQList>> getFaqIjazah(
      String port, String layanan) async {
    var uri = Uri.parse('$urlStagging/faq?module_code=$layanan');
    var response = await client.get(uri, headers: appHeaders);
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(FAQList.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, StatusByEmail>> getByEmail(
      String port, String keyword) async {
    var uri =
        Uri.parse('$urlStagging/ijazah-ln/status-pengajuan/email?q=$keyword');
    print("URI : $uri");
    try {
      var response = await client
          .get(uri, headers: appHeaders)
          .timeout(Duration(seconds: 2), onTimeout: () {
        throw SocketException('');
      });
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(StatusByEmail.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, StatusByNoReg>> getByNoReg(
      String port, String keyword) async {
    var uri =
        Uri.parse('$urlStagging/ijazah-ln/status-pengajuan/no-reg?q=$keyword');
    try {
      var response = await client
          .get(uri, headers: appHeaders)
          .timeout(Duration(seconds: 3), onTimeout: () {
        throw SocketException('');
      });
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(StatusByNoReg.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, NegaraIjazahLNList>> getNegara(String port) async {
    var uri = Uri.parse('$urlStagging/ijazah-ln/negara');
    try {
      var response = await client
          .get(uri, headers: appHeaders)
          .timeout(Duration(seconds: 1), onTimeout: () {
        throw SocketException('');
      });
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(NegaraIjazahLNList.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, PtIjazahLNList>> getPT(
      String port, String idNegara, String namaUniv) async {
    var uri =
        Uri.parse('$urlStagging/ijazah-ln/negara/$idNegara?nama_pt=$namaUniv');
    try {
      var response = await client
          .get(uri, headers: appHeaders)
          .timeout(Duration(seconds: 1), onTimeout: () {
        throw SocketException('');
      });
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PtIjazahLNList.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, VerifikasiSK>> postVerif(
      String port, String idNegara, String idPT, String nomorSK) async {
    var uri = Uri.parse('$urlStagging/ijazah-ln/verifikasi-sk');
    try {
      final response = await http.post(uri, headers: <String, String>{
        dotenv.get('API_KEY'): dotenv.get('API_VALUE'),
        'Content-Type': 'application/x-www-form-urlencoded',
      }, body: {
        'id_negara': idNegara,
        'id_pt': idPT,
        'nomor_sk': nomorSK
      });
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(VerifikasiSK.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, ProdiPTLN>> getProdiPTLN(String idPT) async {
    var uri = Uri.parse('$urlStagging/ijazah-ln/prodi/$idPT');
    try {
      var response = await client.get(uri, headers: appHeaders);
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(ProdiPTLN.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }
}
