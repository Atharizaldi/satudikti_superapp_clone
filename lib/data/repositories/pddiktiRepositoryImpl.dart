import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getSpecificDosen.dart';
import 'package:app/data/source/remote/model/pddikti/elasticSearch.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getSpecificMahasiswa.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/IDPTPDDIKTI.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListProdi.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getSpecificElasticPT.dart';
import 'package:app/data/source/remote/model/pddikti/perubahan_dosen_tendik/model_perubahan_dosen_tendik.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getSpecificElasticProdi.dart';
import 'package:app/data/source/remote/model/pddikti/status_usulan_dosen/usulan_dosen.dart';
import 'package:app/data/source/remote/model/tableau.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class PddiktiRepositoryImpl extends PddiktiRepository {
  final http.Client client;

  PddiktiRepositoryImpl({required this.client});

  Future<Either<Failure, Tableau>> getStatistic() async {
    // Production Endpoint (Only use on release)
    // var uri = Uri.parse('$urlProd/tableau/pddikti');

    // Dev/Stagging Endpoint
    var uri = Uri.parse('$urlStagging/tableau?module_name=pddikti');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getStatistic: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(Tableau.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetListPT>> getListPTAPI(
      String page, String limit, String keyword) async {
    var uri = Uri.parse(
        '$urlStagging/pddikti/perguruan_tinggi?q=$keyword&limit=$limit&page=$page');
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getListPTAPI: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetListPT.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, IDPTPDDIKTI>> getIDPTPDDIKTI(String id) async {
    var uri = Uri.parse('$urlAPI/v2/pddikti/perguruan_tinggi?q=$id');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d("IDPTPDDIKTI RESPONSE CODE: ${response.statusCode}");
      Logger().d("IDPTPDDIKTI RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(IDPTPDDIKTI.fromJson(jsonData));
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

  Future<Either<Failure, GetListProdi>> getListProdiAPI(
      String idPt, String keyword) async {
    try {
      var uri = Uri.parse(
          '$urlStagging/pddikti/perguruan_tinggi/$idPt/prodi?q=$keyword');

      var response = await client.get(uri, headers: appHeaders);
      Logger().i("getListProdiAPI: ${response.statusCode}");
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

  Future<Either<Failure, GetSpecificElasticPT>> getListElasticPTAPI(
      String keyword) async {
    try {
      var uri = Uri.parse('$urlStagging/pddikti/search_pt?id_pt=$keyword');

      var response = await client.get(uri, headers: appHeaders);
      Logger().i("getElasticPTAPI: ${response.statusCode}");
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(GetSpecificElasticPT.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, Map<String, String>>> getListElasticProvinsi() async {
    var uri = Uri.parse(urlProvinsi);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getListElasticProvinsi: ${response.statusCode}");
    Map<String, String> provinsiMap = {};
    try {
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);

        for (int i = 0; i < jsonData.length; i++) {
          provinsiMap[jsonData[i]['nama']] = jsonData[i]['id'];
        }

        return Right(provinsiMap);
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, ElasticSearch>> getElasticSearch(
      String keyword) async {
    try {
      var uri = Uri.parse('$urlStagging/pddikti/search_dashboard/$keyword');
      var response = await client.get(uri, headers: appHeaders);
      Logger().i("getElasticSearch: ${response.statusCode}");
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(ElasticSearch.fromJson(jsonData));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ConnectionFailure(''));
    }
  }

  Future<Either<Failure, GetSpecificElasticPT>> getPTAPI(
      String npsn, String kodeProvinsi, String tipePT) async {
    var uri = Uri.parse(
        '$urlStagging/pddikti/search_pt?id_pt=$npsn&provinsi=$kodeProvinsi&tipe=$tipePT');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getPTAPI: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetSpecificElasticPT.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetSpecificElasticProdi>> getProdiAPI(String namaProdi,
      String kodePT, String akreditasi, String jenjang) async {
    var uri = Uri.parse(
        '$urlStagging/pddikti/search_prodi?prodi=$namaProdi&id_pt=$kodePT&jenjang=$jenjang&akreditasi=$akreditasi');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getProdiAPI: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetSpecificElasticProdi.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetSpecificMahasiswa>> getDetailMahasiswaAPI(
      String nama, String nim, String kodePT, String kodePD) async {
    var uri = Uri.parse(
        '$urlStagging/pddikti/mahasiswa/$nama/$nim?id_pt=$kodePT&id_pd=$kodePD');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getDetailMahasiswaAPI: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetSpecificMahasiswa.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, GetSpecificDosen>> getDetailDosenAPI(
      String nama, String nidn, String kodePT) async {
    var uri;
    if (kodePT.length < 2) {
      uri = Uri.parse('$urlStagging/pddikti/search_dosen/$nama/$nidn');
      print("uri");
    } else {
      uri = Uri.parse(
          '$urlStagging/pddikti/search_dosen/$nama/$nidn?kode_pt=$kodePT');
    }
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("getDetailDosenAPI: ${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(GetSpecificDosen.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }

  // Cek Status Riwayat Usulan Dosen
  Future<Either<Failure, UsulanDosenResponse>> getUsulanDosen(String namaDosen,
      String tanggalLahir, String idPT, String nidn, String isLogin) async {
    print("nama tanggalLahir $tanggalLahir");
    var uri = Uri.parse(
        '$urlAPI/v3/forlap/dosen/registrasi?id-pt=$idPT&q=$namaDosen&tgl-lahir=$tanggalLahir&is-login=$isLogin&nidn=$nidn');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d(" RESPONSE CODE: ${response.statusCode}");
      Logger().d(" RESPONSE BODY: ${response.body}");
      Logger().d(" RESPONSE REQUEST: ${response.request}");

      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(UsulanDosenResponse.fromJson(jsonData));
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

  //Perubahan Dosen Dan Tendik

  Future<Either<Failure, PerubahanDosenTendikResponse>> listUDosenDanTendik(
      String nidn, int page) async {
    var uri = Uri.parse(
        '$urlAPI/v2/forlap/dosen/perubahan?id=$nidn&q=&nik=&nm-ibu-kandung=&tgl-lahir=&page=$page&per-page=5');
    print(uri);
    var response = await client.get(uri, headers: appHeaders);
    Logger().i("listUDosenDanTendik status code: ${response.statusCode}");
    Logger().i("listUDosenDanTendik response body: ${response.body}");
    if (response.statusCode == 200) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      return Right(PerubahanDosenTendikResponse.fromJson(jsonData));
    } else {
      return Left(ServerFailure(''));
    }
  }
}
