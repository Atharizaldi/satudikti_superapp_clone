import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getDetailDosen.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatMengajar.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatPendidikan.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getDetailMahasiswa.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getDetailMahasiswaReg.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStatusKuliah.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStudi.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAgregatPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAkreditasiPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getDetailPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getPelaporanPT.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getDetailProdi.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getDetailProdiReg.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListDosenProdi.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getRasioMhsDosen.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class PddiktiDetailRepositoryImpl extends PddiktiDetailRepository {
  final http.Client client;

  PddiktiDetailRepositoryImpl({required this.client});

// REPOSITORY IMPLEMENTATION FOR MAHASISWA

  Future<Either<Failure, GetDetailMahasiswa>> getMahasiswaPageAPI(
      String nim, String kodePT, String kodePD) async {
    var uriDetail = Uri.parse(
        '$urlStagging/pddikti/mahasiswa/$nim/perguruan_tinggi/${kodePT.substring(0, 6)}/prodi/$kodePD/detail_mahasiswa');
    print(uriDetail);
    var responseDetail = await client.get(uriDetail, headers: appHeaders);
    Logger().i("getElasticSearch: ${responseDetail.statusCode}");

    if (responseDetail.statusCode == 200) {
      String jsonDataString = responseDetail.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetDetailMahasiswa.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetDetailMahasiswaReg>> getMahasiswaPageAPIReg(
      String nim) async {
    var uriDetail =
        Uri.parse('$urlStagging/pddikti/mahasiswa/$nim/detail_mahasiswa');

    print(uriDetail);

    var responseDetail = await client.get(uriDetail, headers: appHeaders);
    Logger().i("getElasticSearch: ${responseDetail.statusCode}");
    if (responseDetail.statusCode == 200) {
      String jsonDataString = responseDetail.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetDetailMahasiswaReg.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, RiwayatStatusKuliah>> getRiwayatKuliahMahasiswa(
      String nim, String kodePT, String kodePD) async {
    var uriRiwayatKuliah = Uri.parse(
        '$urlStagging/pddikti/mahasiswa/$nim/perguruan_tinggi/$kodePT/prodi/$kodePD/riwayat_status_kuliah');

    var responseRiwayatKuliah =
        await client.get(uriRiwayatKuliah, headers: appHeaders);
    Logger().i("getElasticSearch: ${responseRiwayatKuliah.statusCode}");

    print(uriRiwayatKuliah);

    if (responseRiwayatKuliah.statusCode == 200) {
      String jsonDataString = responseRiwayatKuliah.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(RiwayatStatusKuliah.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, RiwayatStudiMahasiswa>> getRiwayatStudiMahasiswaReg(
      String nim, String kodePT, String kodePD) async {
    var uriRiwayatStudi = Uri.parse(
        '$urlStagging/pddikti/mahasiswa/$nim/perguruan_tinggi/$kodePT/prodi/$kodePD/riwayat_studi');
    print("uriRIWAYATSTUDI $uriRiwayatStudi");
    var responseRiwayatStudi =
        await client.get(uriRiwayatStudi, headers: appHeaders);
    Logger().i("getElasticSearch: ${responseRiwayatStudi.statusCode}");

    print(uriRiwayatStudi);

    if (responseRiwayatStudi.statusCode == 200) {
      String jsonDataString = responseRiwayatStudi.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(RiwayatStudiMahasiswa.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  // REPOSITORY IMPLEMENTATION FOR DOSEN

  Future<Either<Failure, GetDetailDosen>> getDetailDosenPageAPI(
      String nidn) async {
    var uriDetail = Uri.parse('$urlStagging/pddikti/dosen/$nidn');

    print(uriDetail);
    var responseDetail = await client.get(uriDetail, headers: appHeaders);
    Logger().i("getElasticSearch: ${responseDetail.statusCode}");
    if (responseDetail.statusCode == 200) {
      String jsonDataString = responseDetail.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetDetailDosen.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, RiwayatPendidikan>> getRiwayatPendidikanDosenAPI(
      String nidn) async {
    var uriRiwayatPendidikan =
        Uri.parse('$urlStagging/pddikti/dosen/$nidn/pendidikan');
    print(uriRiwayatPendidikan);

    var responseRiwayatPendidikan =
        await client.get(uriRiwayatPendidikan, headers: appHeaders);
    Logger().i("getElasticSearch: ${responseRiwayatPendidikan.statusCode}");

    if (responseRiwayatPendidikan.statusCode == 200) {
      String jsonDataString = responseRiwayatPendidikan.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(RiwayatPendidikan.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, RiwayatMengajar>> getRiwayatMengajarDosenAPI(
      String nidn) async {
    var uriRiwayatMengajar =
        Uri.parse('$urlStagging/pddikti/dosen/$nidn/mengajar');

    print(uriRiwayatMengajar);

    var responseRiwayatMengajar =
        await client.get(uriRiwayatMengajar, headers: appHeaders);
    Logger().i("getElasticSearch: ${responseRiwayatMengajar.statusCode}");
    if (responseRiwayatMengajar.statusCode == 200) {
      String jsonDataString = responseRiwayatMengajar.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(RiwayatMengajar.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  // REPOSITORY IMPLEMENTATION FOR PERGURUAN TINGGI

  Future<Either<Failure, GetDetailPT>> getDetailPTAPI(String kodePT) async {
    var uri1 = Uri.parse('$urlStagging/pddikti/perguruan_tinggi/$kodePT');
    print(uri1);

    var response1 = await client.get(uri1, headers: appHeaders);
    Logger().i("getElasticSearch: ${response1.statusCode}");
    if (response1.statusCode == 200) {
      String jsonDataString1 = response1.body.toString();
      var jsonData1 = jsonDecode(jsonDataString1);
      return Right(GetDetailPT.fromJson(jsonData1));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetAgregatPT>> getAgregatPTAPI(String ptId) async {
    var uri =
        Uri.parse('$urlStagging/pddikti/perguruan_tinggi/$ptId/agregat_dosen');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getElasticSearch: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString1 = response.body.toString();
      var jsonData = jsonDecode(jsonDataString1);
      return Right(GetAgregatPT.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetPelaporanPT>> getPelaporanPTAPI(String ptId) async {
    var uri =
        Uri.parse('$urlStagging/pddikti/perguruan_tinggi/$ptId/pelaporan');
    print(uri);
    var response3 = await client.get(uri, headers: appHeaders);
    Logger().i("getElasticSearch: ${response3.statusCode}");
    if (response3.statusCode == 200) {
      String jsonDataString3 = response3.body.toString();
      var jsonData3 = jsonDecode(jsonDataString3);
      return Right(GetPelaporanPT.fromJson(jsonData3));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetAkreditasiPT>> getAkreditasiPTAPI(
      String ptId) async {
    var uri =
        Uri.parse('$urlStagging/pddikti/perguruan_tinggi/$ptId/akreditasi');
    print(uri);

    var response4 = await client.get(uri, headers: appHeaders);
    Logger().i("getElasticSearch: ${response4.statusCode}");
    if (response4.statusCode == 200) {
      String jsonDataString4 = response4.body.toString();
      var jsonData4 = jsonDecode(jsonDataString4);
      return Right(GetAkreditasiPT.fromJson(jsonData4));
    } else {
      return Left(ServerFailure(''));
    }
  }

  // REPOSITORY IMPLEMENTATION FOR PRODI

  Future<Either<Failure, GetDetailProdi>> getDetailProdiAPI(
      String kodeProdi, String kodePT, bool fromPT) async {
    if (fromPT == false) {
      kodePT = kodePT.substring(0, 6);
    }
    var uri = Uri.parse(
        '$urlStagging/pddikti/perguruan_tinggi/$kodePT/prodi/$kodeProdi');
    print("INI $uri");
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getElasticSearch: ${response.statusCode}");
    Logger().d('Response Request  : ${response.request}');
    Logger().d('Response Body: ${response.body.toString()}');
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetDetailProdi.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetDetailProdiReg>> getDetailProdiAPIReg(
      String idReg) async {
    var uri = Uri.parse('$urlStagging/pddikti/prodi/$idReg');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getElasticSearch: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetDetailProdiReg.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetListDosenProdi>> getListDosenProdiAPI(
      String kodeProdi, String kodePT) async {
    var uri = Uri.parse(
        '$urlStagging/pddikti/perguruan_tinggi/$kodePT/prodi/$kodeProdi/dosen');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getElasticSearch: ${response.statusCode}");
    Logger().d('Response Request  : ${response.request}');
    Logger().d('Response Body : ${response.body.toString()}');
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetListDosenProdi.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetRasioMhsDosen>> getRasioProdiAPI(
      String kodeProdi, String kodePT) async {
    /* print('Kode PT :::::::::::: '+kodePT.toString()); */
    var uri = Uri.parse(
        '$urlStagging/pddikti/perguruan_tinggi/$kodePT/prodi/$kodeProdi/rasio_dosen_mahasiswa?mulai_tahun=2018&sampai_tahun=2022');
    print(uri);

    var response = await client.get(uri, headers: appHeaders);
    Logger().i('Response Request  rasio: ${response.request}');
    Logger().i("getElasticSearch: ${response.statusCode}");
    Logger().i('Response Body rasio: ${response.body.toString()}');
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetRasioMhsDosen.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetAkreditasiPT>> getAkreditasiProdiAPI(
      String kodeProdi, String kodePT) async {
    var uri = Uri.parse(
        '$urlStagging/pddikti/perguruan_tinggi/$kodePT/prodi/$kodeProdi/akreditasi');
    print(uri);

    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getElasticSearch: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetAkreditasiPT.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
