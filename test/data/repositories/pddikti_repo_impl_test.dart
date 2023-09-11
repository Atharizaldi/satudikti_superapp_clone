import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/repositories/pddiktiRepositoryImpl.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getSpecificDosen.dart';
import 'package:app/data/source/remote/model/pddikti/elasticSearch.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getSpecificMahasiswa.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListProdi.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getSpecificElasticPT.dart';
import 'package:app/data/source/remote/model/pddikti/perubahan_dosen_tendik/model_perubahan_dosen_tendik.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getSpecificElasticProdi.dart';
import 'package:app/data/source/remote/model/pddikti/status_usulan_dosen/usulan_dosen.dart';
import 'package:app/data/source/remote/model/tableau.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mock_client.mocks.dart';
import '../../json_reader.dart';

@GenerateMocks([])
void main() {
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  late MockClient client;
  late PddiktiRepositoryImpl pddiktiRepositoryImpl;

  setUp(() {
    client = MockClient();
    pddiktiRepositoryImpl = PddiktiRepositoryImpl(client: client);
  });

  group("get Statistic", () {
    final String url = "$urlStagging/tableau?module_name=pddikti";
    final String filePath = "/dummy_data/pddikti/tableau/tableau.json";
    final expectedTableau = Tableau.fromJson(jsonDecode(readFile(filePath)));
    test("should return getStatistic with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.getStatistic();
      var actual;
      result.fold((failure) => actual = failure,
          (getstatistic) => actual = getstatistic);

      expect(actual.data, equals(expectedTableau.data));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 404, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
      });
      final result = await pddiktiRepositoryImpl.getStatistic();
      var actual;
      result.fold((failure) => actual = failure,
          (tableaupddikti) => actual = tableaupddikti);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("List PT", () {
    final String keyword = "Universitas Hasanuddin";
    final String limit = "";
    final String page = "";
    final String url =
        "$urlStagging/pddikti/perguruan_tinggi?q=$keyword&limit=$limit&page=$page";
    final String filePath = "/dummy_data/pddikti/list_pt/list_pt.json";
    final expectedGetListPT =
        GetListPT.fromJson(jsonDecode(readFile(filePath)));
    test("should return getListPT with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result =
          await pddiktiRepositoryImpl.getListPTAPI(page, limit, keyword);
      var actual;
      result.fold(
          (failure) => actual = failure, (getlistpt) => actual = getlistpt);

      expect(actual.data!.perguruanTinggi[0].kode,
          equals(expectedGetListPT.data.perguruanTinggi[0].kode));

      expect(actual.data!.perguruanTinggi[0].namaSingkat,
          equals(expectedGetListPT.data.perguruanTinggi[0].namaSingkat));

      expect(actual.data!.perguruanTinggi[0].status,
          equals(expectedGetListPT.data.perguruanTinggi[0].status));

      expect(actual.data!.perguruanTinggi[0].akreditasi,
          equals(expectedGetListPT.data.perguruanTinggi[0].akreditasi));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result =
          await pddiktiRepositoryImpl.getListPTAPI(page, limit, keyword);
      var actual;
      result.fold(
          (failure) => actual = failure, (getlistpt) => actual = getlistpt);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("List Prodi", () {
    final String keyword = "teknik";
    final String idPt = "064078";
    final String url =
        "$urlStagging/pddikti/perguruan_tinggi/$idPt/prodi?q=$keyword";
    final String filePath = "/dummy_data/pddikti/list_prodi/list_prodi.json";
    final expectedGetListProdi =
        GetListProdi.fromJson(jsonDecode(readFile(filePath)));
    test("should return getListPT with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.getListProdiAPI(idPt, keyword);
      var actual;
      result.fold((failure) => actual = failure,
          (getlistprodi) => actual = getlistprodi);

      expect(actual.data.prodi[0].nama,
          equals(expectedGetListProdi.data.prodi[0].nama));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiRepositoryImpl.getListProdiAPI(idPt, keyword);
      var actual;
      result.fold(
          (failure) => actual = failure, (getlistpt) => actual = getlistpt);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("List Elastic PT", () {
    final String keyword = "001005";
    final String url = "$urlStagging/pddikti/search_pt?id_pt=$keyword";
    final String filePath = "/dummy_data/pddikti/elastic_pt/elastic_pt.json";
    final expectedElasticPT =
        GetSpecificElasticPT.fromJson(jsonDecode(readFile(filePath)));
    test("should return getElasticPT with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.getListElasticPTAPI(keyword);
      var actual;
      result.fold(
          (failure) => actual = failure, (spesificPT) => actual = spesificPT);

      expect(actual.data.pt[0].nama, equals(expectedElasticPT.data.pt[0].nama));
      expect(actual.data.pt[0].npsn, equals(expectedElasticPT.data.pt[0].npsn));
      expect(actual.data.pt[0].website,
          equals(expectedElasticPT.data.pt[0].website));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiRepositoryImpl.getListElasticPTAPI(keyword);
      var actual;
      result.fold(
          (failure) => actual = failure, (spesificPT) => actual = spesificPT);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("List Elastic Provinsi", () {
    final String url = "https://api-frontend.kemdikbud.go.id/get_provinsi";
    Map<String, String> expectedLisElasticProvinsi = {};
    final String filePath =
        "/dummy_data/pddikti/elastic_prov/elastic_prov.json";
    var jsonData = jsonDecode(readFile(filePath));
    for (int i = 0; i < jsonData.length; i++) {
      expectedLisElasticProvinsi[jsonData[i]['nama']] = jsonData[i]['id'];
    }
    test("should return getElasticSearch with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.getListElasticProvinsi();
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);

      expect(actual, equals(expectedLisElasticProvinsi));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiRepositoryImpl.getListElasticProvinsi();
      var actual;
      result.fold(
          (failure) => actual = failure, (spesificPT) => actual = spesificPT);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("List Elastic Search", () {
    final String keyword = "univ";
    final String url = "$urlStagging/pddikti/search_dashboard/$keyword";
    final String filePath =
        "/dummy_data/pddikti/elastic_search/elastic_search.json";
    final expectedElasticSearch =
        ElasticSearch.fromJson(jsonDecode(readFile(filePath)));
    test("should return getElasticSearch with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.getElasticSearch(keyword);
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);

      expect(actual.data!.dashboard!.pt,
          equals(expectedElasticSearch.data!.dashboard!.pt));
      expect(actual.data!.dashboard!.prodi,
          equals(expectedElasticSearch.data!.dashboard!.prodi));
      expect(actual.data!.dashboard!.dosen,
          equals(expectedElasticSearch.data!.dashboard!.dosen));
      expect(actual.data!.dashboard!.mahasiswa,
          equals(expectedElasticSearch.data!.dashboard!.mahasiswa));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiRepositoryImpl.getElasticSearch(keyword);
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);
      print(actual.toString());
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("Get PT API", () {
    final String npsn = "001002";
    final String kodeProvinsi = "010000";
    final String tipePT = "Negeri";
    final String url =
        "$urlStagging/pddikti/search_pt?id_pt=$npsn&provinsi=$kodeProvinsi&tipe=$tipePT";
    final String filePath = "/dummy_data/pddikti/elastic_pt/get_pt.json";
    final expectedSpecificElasticPT =
        GetSpecificElasticPT.fromJson(jsonDecode(readFile(filePath)));
    test("should return getptAPI with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result =
          await pddiktiRepositoryImpl.getPTAPI(npsn, kodeProvinsi, tipePT);
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);

      expect(actual.data.pt[0].nama,
          equals(expectedSpecificElasticPT.data.pt[0].nama));
      expect(actual.data.pt[0].npsn,
          equals(expectedSpecificElasticPT.data.pt[0].npsn));
      expect(actual.data.pt[0].website,
          equals(expectedSpecificElasticPT.data.pt[0].website));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result =
          await pddiktiRepositoryImpl.getPTAPI(npsn, kodeProvinsi, tipePT);
      var actual;
      result.fold(
          (failure) => actual = failure, (spesificPT) => actual = spesificPT);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("Get Prodi API", () {
    final String namaProdi = "Ilmu Komputer";
    final String kodePT = "001002";
    final String jenjang = "S1";
    final String akreditasi = "Unggul";
    final String url =
        "$urlStagging/pddikti/search_prodi?prodi=$namaProdi&id_pt=$kodePT&jenjang=$jenjang&akreditasi=$akreditasi";
    final String filePath =
        "/dummy_data/pddikti/elastic_prodi/elastic_prodi.json";
    final expectedSpecificElasticProdi =
        GetSpecificElasticProdi.fromJson(jsonDecode(readFile(filePath)));
    test("should return getptAPI with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.getProdiAPI(
          namaProdi, kodePT, akreditasi, jenjang);
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);

      expect(
          actual.data.prodi, equals(expectedSpecificElasticProdi.data.prodi));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiRepositoryImpl.getProdiAPI(
          namaProdi, kodePT, akreditasi, jenjang);
      var actual;
      result.fold(
          (failure) => actual = failure, (spesificPT) => actual = spesificPT);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("Get Detail Mahasiswa", () {
    final String nama = "Muhammad";
    final String nim = "212061013";
    final String kodePT = "033127";
    final String kodePD = "57201";
    final String url =
        "$urlStagging/pddikti/mahasiswa/$nama/$nim?id_pt=$kodePT&id_pd=$kodePD";
    final String filePath =
        "/dummy_data/pddikti/mahasiswa/detail_mahasiswa.json";
    final expectedDetaiMahasiswa =
        GetSpecificMahasiswa.fromJson(jsonDecode(readFile(filePath)));
    test("should return getDetailMahasiswa with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.getDetailMahasiswaAPI(
          nama, nim, kodePT, kodePD);
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);

      expect(
          actual.data.mahasiswa, equals(expectedDetaiMahasiswa.data.mahasiswa));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiRepositoryImpl.getDetailMahasiswaAPI(
          nama, nim, kodePT, kodePD);
      var actual;
      result.fold((failure) => actual = failure,
          (detailMahasiswa) => actual = detailMahasiswa);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("Get Detail Dosen", () {
    final String nama = "Risna Sari";
    final String nidn = "0027028506";
    final String kodePT = "005002";
    final String url =
        "$urlStagging/pddikti/search_dosen/$nama/$nidn?kode_pt=$kodePT";
    final String filePath = "/dummy_data/pddikti/dosen/detail_dosen.json";
    final expectedDetaiDosen =
        GetSpecificDosen.fromJson(jsonDecode(readFile(filePath)));
    test("should return getDetailDosen with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result =
          await pddiktiRepositoryImpl.getDetailDosenAPI(nama, nidn, kodePT);
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);

      expect(actual.data.dosen, equals(expectedDetaiDosen.data.dosen));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result =
          await pddiktiRepositoryImpl.getDetailDosenAPI(nama, nidn, kodePT);
      var actual;
      result.fold(
          (failure) => actual = failure, (detailDosen) => actual = detailDosen);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("Get Usulan Dosen", () {
    final String namaDosen = "M. Zein";
    final String namaIbuKandung = "Alwia";
    final String tanggalLahir = "1972-07-26";
    final String nidn = "1312312412";
    final String islogin = "false";
    final String url =
        "$urlStagging/forlap/dosen/registrasi?q=$namaDosen&nik&nm-ibu-kandung=$namaIbuKandung&tgl-lahir=$tanggalLahir&page=0&per-page=5&fields";
    final String filePath = "/dummy_data/pddikti/dosen/usulan_dosen.json";
    final expectedDetaiDosen =
        UsulanDosenResponse.fromJson(jsonDecode(readFile(filePath)));
    test("should return getUsulanDosen with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.getUsulanDosen(
          namaDosen, tanggalLahir, namaIbuKandung, nidn, islogin);
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);

      expect(actual.data!.listUsulanDosen![0].nip,
          equals(expectedDetaiDosen.data!.listUsulanDosen![0].nip));
      expect(actual.data!.listUsulanDosen![0].nik,
          equals(expectedDetaiDosen.data!.listUsulanDosen![0].nik));
      expect(actual.data!.listUsulanDosen![0].nama,
          equals(expectedDetaiDosen.data!.listUsulanDosen![0].nama));
      expect(actual.data!.listUsulanDosen![0].namaIbuKandung,
          equals(expectedDetaiDosen.data!.listUsulanDosen![0].namaIbuKandung));
      expect(actual.data!.listUsulanDosen![0].gelarDepan,
          equals(expectedDetaiDosen.data!.listUsulanDosen![0].gelarDepan));
      expect(actual.data!.listUsulanDosen![0].gelarBelakang,
          equals(expectedDetaiDosen.data!.listUsulanDosen![0].gelarBelakang));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiRepositoryImpl.getUsulanDosen(
          namaDosen, tanggalLahir, namaIbuKandung, nidn, islogin);
      var actual;
      result.fold(
          (failure) => actual = failure, (detailDosen) => actual = detailDosen);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group("List Dosen dan Tendik", () {
    final String nidn = "0004086501";
    final String url =
        "$urlStagging/forlap/dosen/perubahan?id=$nidn&q=&nik=&nm-ibu-kandung=&tgl-lahir=&page=0&per-page=5";
    final String filePath = "/dummy_data/pddikti/dosen/dosenTendik.json";
    final expectedListDosenTendik =
        PerubahanDosenTendikResponse.fromJson(jsonDecode(readFile(filePath)));
    test("should return list Dosen & Tendik with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiRepositoryImpl.listUDosenDanTendik(nidn, 2);
      var actual;
      result.fold((failure) => actual = failure, (search) => actual = search);

      expect(
          actual.data!.listPerubahanDosenTendikResponse,
          equals(
              expectedListDosenTendik.data!.listPerubahanDosenTendikResponse));
    });
    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiRepositoryImpl.listUDosenDanTendik(nidn, 2);
      var actual;
      result.fold(
          (failure) => actual = failure, (dosenTendik) => actual = dosenTendik);
      expect(actual, equals(ServerFailure('')));
    });
  });
}
