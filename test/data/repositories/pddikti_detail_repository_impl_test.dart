import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/repositories/pddiktiDetailRepositoryImpl.dart';
import 'package:app/data/repositories/pddiktiRepositoryImpl.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mock_client.mocks.dart';
import '../../json_reader.dart';

@GenerateMocks([http.Client])
void main() {
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  late MockClient client;
  late PddiktiDetailRepositoryImpl pddiktiDetailRepositoryImpl;
  late PddiktiRepositoryImpl pddiktiRepositoryImpl;

  setUp(() async {
    client = MockClient();
    pddiktiDetailRepositoryImpl = PddiktiDetailRepositoryImpl(client: client);
    pddiktiRepositoryImpl = PddiktiRepositoryImpl(client: client);
  });

  group('get Detail Mahasiswa', () {
    final String nim = '201931193';
    final String kodePT = '033104';
    final String kodePD = '55201';
    final String url =
        '$urlStagging/pddikti/mahasiswa/$nim/perguruan_tinggi/${kodePT.substring(0, 6)}/prodi/$kodePD/detail_mahasiswa';
    final String filePath =
        'dummy_data/pddikti_detail_repository_impl/get_detail_2/detail.json';
    final expectedDetail =
        GetDetailMahasiswa.fromJson(jsonDecode(readFile(filePath)));
    test('should return Detail Mahasiswa', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final resutl = await pddiktiDetailRepositoryImpl.getMahasiswaPageAPI(
          nim, kodePT, kodePD);
      var actual;
      resutl.fold(
          (failure) => actual = failure, (getDetail) => actual = getDetail);
      expect(actual.data.mahasiswa, equals(expectedDetail.data.mahasiswa));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiDetailRepositoryImpl.getMahasiswaPageAPI(
          nim, kodePT, kodePD);
      var actual;
      result.fold(
          (failure) => actual = failure, (getDetail) => actual = getDetail);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Detail Mahasiswa Reg', () {
    String idReg = 'NzNDMjREQkQtMEExRC00MjFFLUFBNTgtOEJCNjhCNzlEQjQz';
    final filePath2 =
        '/dummy_data/pddikti_detail_repository_impl/get_detail_mhs/detail_mhs.json';
    final expected =
        GetDetailMahasiswaReg.fromJson(jsonDecode(readFile(filePath2)));
    test('should return Detail Mahasiswa Reg with response code by 200',
        () async {
      when(client.get(
              Uri.parse(
                  "$urlStagging/pddikti/mahasiswa/$idReg/detail_mahasiswa"),
              headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath2), 200);
      });

      var actual2;
      final result2 =
          await pddiktiDetailRepositoryImpl.getMahasiswaPageAPIReg(idReg);

      result2.fold((failure) => actual2 = failure, (idReg) => actual2 = idReg);

      expect(actual2.data.mahasiswa[0].nama,
          equals(expected.data.mahasiswa[0].nama));
      expect(actual2.data.mahasiswa[0].jenisKelamin,
          equals(expected.data.mahasiswa[0].jenisKelamin));
      expect(actual2.data.mahasiswa[0].terdaftar,
          equals(expected.data.mahasiswa[0].terdaftar));
    });
    test('should return ServerFailure', () async {
      when(client.get(
              Uri.parse(
                  "$urlStagging/pddikti/mahasiswa/$idReg/detail_mahasiswa"),
              headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath2), 500);
      });

      var actual2;
      final result2 =
          await pddiktiDetailRepositoryImpl.getMahasiswaPageAPIReg(idReg);
      result2.fold((failure) => actual2 = failure, (idReg) => actual2 = idReg);
      expect(actual2, equals(ServerFailure('')));
    });
  });

  group('get Riwayat Status Kuliah by id', () {
    final String nim = '201931193';
    final String kodePT = '033104';
    final String kodePD = '55201';
    final String url =
        '$urlStagging/pddikti/mahasiswa/$nim/perguruan_tinggi/$kodePT/prodi/$kodePD/riwayat_status_kuliah';
    final String filePath =
        "/dummy_data/pddikti_detail_repository_impl/get_riwayat_status_kuliah/riwayat_status_kuliah.json";
    final expectedResponse =
        RiwayatStatusKuliah.fromJson(jsonDecode(readFile(filePath)));
    test('should return Riwayat Status Kuliah with response code 200',
        () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiDetailRepositoryImpl
          .getRiwayatKuliahMahasiswa(nim, kodePT, kodePD);
      var actual;

      result.fold((failure) => actual = failure,
          (getRiwayatKuliahMahasiswa) => actual = getRiwayatKuliahMahasiswa);
      expect(
          actual.data.mahasiswa[0], equals(expectedResponse.data.mahasiswa[0]));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiDetailRepositoryImpl
          .getRiwayatKuliahMahasiswa(nim, kodePT, kodePD);
      var actual;
      result.fold((failure) => actual = failure,
          (getRiwayatKuliahMahasiswa) => actual = getRiwayatKuliahMahasiswa);
      expect(actual, equals(ServerFailure("")));
    });
  });

  group('get Riwayat Studi Mahasiswa', () {
    final String nim = '201931193';
    final String kodePT = '033104';
    final String kodePD = '55201';
    final String url =
        '$urlStagging/pddikti/mahasiswa/$nim/perguruan_tinggi/$kodePT/prodi/$kodePD/riwayat_studi';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_riwayat_studi_mhs/riwayat_studi_mhs.json';
    final expectedResponse =
        RiwayatStudiMahasiswa.fromJson(jsonDecode(readFile(filePath)));
    test('should return Riwayat Studi Mhs with response code 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiDetailRepositoryImpl
          .getRiwayatStudiMahasiswaReg(nim, kodePT, kodePD);
      var actual;
      result.fold(
          (failure) => actual = failure,
          (getRiwayatStudiMahasiswaReg) =>
              actual = getRiwayatStudiMahasiswaReg);
      expect(actual.data.mahasiswa, equals(expectedResponse.data.mahasiswa));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiDetailRepositoryImpl
          .getRiwayatStudiMahasiswaReg(nim, kodePT, kodePD);
      var actual;
      result.fold(
          (failure) => actual = failure,
          (getRiwayatStudiMahasiswaReg) =>
              actual = getRiwayatStudiMahasiswaReg);
      expect(actual, equals(ServerFailure("")));
    });
  });

  group('get Detail Dosen by id', () {
    final String nidn = '0424048002';
    final String url = '$urlStagging/pddikti/dosen/$nidn';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_detail_dosen/detail_dosen.json';
    final expectedResponse =
        GetDetailDosen.fromJson(jsonDecode(readFile(filePath)));
    test('should return Detail Dosen with response code 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result =
          await pddiktiDetailRepositoryImpl.getDetailDosenPageAPI(nidn);
      var actual;
      result.fold((failure) => actual = failure,
          (getDetailDosenPageAPI) => actual = getDetailDosenPageAPI);
      expect(actual.data.dosen, equals(expectedResponse.data.dosen));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result =
          await pddiktiDetailRepositoryImpl.getDetailDosenPageAPI(nidn);
      var actual;
      result.fold((failure) => actual = failure,
          (getDetailDosenPageAPI) => actual = getDetailDosenPageAPI);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Riwayat Pendidikan Dosen by id', () {
    final String nidn = '0424048002';
    final String url = '$urlStagging/pddikti/dosen/$nidn/pendidikan';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_riwayat_pendidikan_dosen/riwayat_pendidikan_dosen.json';
    final expectedResponse =
        RiwayatPendidikan.fromJson(jsonDecode(readFile(filePath)));
    test('should return Riwayat Pendidikan Dosen with response code 200',
        () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result =
          await pddiktiDetailRepositoryImpl.getRiwayatPendidikanDosenAPI(nidn);
      var actual;
      result.fold((failure) => actual = failure,
          (riwayatPendidikan) => actual = riwayatPendidikan);
      expect(actual.data.riwayat, equals(expectedResponse.data.riwayat));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result =
          await pddiktiDetailRepositoryImpl.getRiwayatPendidikanDosenAPI(nidn);
      var actual;
      result.fold((failure) => actual = failure,
          (riwayatPendidikan) => actual = riwayatPendidikan);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Riwayat Mengajar Dosen by id', () {
    final String nidn = '0424048002';
    final String url = '$urlStagging/pddikti/dosen/$nidn/mengajar';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_riwayat_mengajar_dosen/riwayat_mengajar_dosen.json';
    final expectedResponse =
        RiwayatMengajar.fromJson(jsonDecode(readFile(filePath)));
    test('should return Riwayat Mengajar with response code 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result =
          await pddiktiDetailRepositoryImpl.getRiwayatMengajarDosenAPI(nidn);
      var actual;
      result.fold((failure) => actual = failure,
          (riwayatMengajar) => actual = riwayatMengajar);
      expect(actual.data.riwayat, equals(expectedResponse.data.riwayat));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result =
          await pddiktiDetailRepositoryImpl.getRiwayatMengajarDosenAPI(nidn);
      var actual;
      result.fold((failure) => actual = failure,
          (riwayatMengajar) => actual = riwayatMengajar);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Detail PT', () {
    final String kodePT = '033104';
    final String url = '$urlStagging/pddikti/perguruan_tinggi/$kodePT';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_detail_pt/detail_pt.json';
    final expectedResponse =
        GetDetailPT.fromJson(jsonDecode(readFile(filePath)));
    test('should return Detail PT with response code 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiDetailRepositoryImpl.getDetailPTAPI(kodePT);
      var actual;
      result.fold(
          (failure) => actual = failure, (detailPt) => actual = detailPt);
      expect(actual.data.perguruanTinggi.kode,
          equals(expectedResponse.data.perguruanTinggi.kode));
      expect(actual.data.perguruanTinggi.nama,
          equals(expectedResponse.data.perguruanTinggi.nama));
      expect(actual.data.perguruanTinggi.namaSingkat,
          equals(expectedResponse.data.perguruanTinggi.namaSingkat));
      expect(actual.data.perguruanTinggi.urlLogo,
          equals(expectedResponse.data.perguruanTinggi.urlLogo));
      expect(actual.data.perguruanTinggi.status,
          equals(expectedResponse.data.perguruanTinggi.status));
      expect(actual.data.perguruanTinggi.skPendirian,
          equals(expectedResponse.data.perguruanTinggi.skPendirian));
      expect(actual.data.perguruanTinggi.tglSkPendirian,
          equals(expectedResponse.data.perguruanTinggi.tglSkPendirian));
      expect(actual.data.perguruanTinggi.alamat,
          equals(expectedResponse.data.perguruanTinggi.alamat));
      expect(actual.data.perguruanTinggi.propinsi,
          equals(expectedResponse.data.perguruanTinggi.propinsi));
      expect(actual.data.perguruanTinggi.telepon,
          equals(expectedResponse.data.perguruanTinggi.telepon));
      expect(actual.data.perguruanTinggi.faksimile,
          equals(expectedResponse.data.perguruanTinggi.faksimile));
      expect(actual.data.perguruanTinggi.website,
          equals(expectedResponse.data.perguruanTinggi.website));
      expect(actual.data.perguruanTinggi.email,
          equals(expectedResponse.data.perguruanTinggi.email));
      expect(actual.data.perguruanTinggi.pimpinan,
          equals(expectedResponse.data.perguruanTinggi.pimpinan));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiDetailRepositoryImpl.getDetailPTAPI(kodePT);
      var actual;
      result.fold(
          (failure) => actual = failure, (detailPt) => actual = detailPt);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Agregat PT by id', () {
    String ptId =
        'nL8MBfMgFpJtOEFKnJOJ3R4HIOLRpxeHTlMVUDclGQ2-QAKDbSxhylG7vlYVTHQL6Hzqdw==';
    final String url =
        '$urlStagging/pddikti/perguruan_tinggi/$ptId/agregat_dosen';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_agregat_pt/agregat_pt.json';
    final expectedResponse =
        GetAgregatPT.fromJson(jsonDecode(readFile(filePath)));
    test('should return Agregat Dosen with response code by 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      var actual;
      final result = await pddiktiDetailRepositoryImpl.getAgregatPTAPI(ptId);
      result.fold((failure) => actual = failure, (ptId) => actual = ptId);

      expect(actual.data.agregatDosen.dosenTetap.registrasi[0],
          equals(expectedResponse.data.agregatDosen.dosenTetap.registrasi[0]));
      expect(actual.data.agregatDosen.dosenTetap.jabatan[0],
          equals(expectedResponse.data.agregatDosen.dosenTetap.jabatan[0]));
      expect(actual.data.agregatDosen.dosenTetap.jenjang[0],
          equals(expectedResponse.data.agregatDosen.dosenTetap.jenjang[0]));
      expect(
          actual.data.agregatDosen.dosenTidakTetap.registrasi[0],
          equals(expectedResponse
              .data.agregatDosen.dosenTidakTetap.registrasi[0]));
      expect(
          actual.data.agregatDosen.dosenTidakTetap.jabatan[0],
          equals(
              expectedResponse.data.agregatDosen.dosenTidakTetap.jabatan[0]));
      expect(
          actual.data.agregatDosen.dosenTidakTetap.jenjang[0],
          equals(
              expectedResponse.data.agregatDosen.dosenTidakTetap.jenjang[0]));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      var actual;
      final result = await pddiktiDetailRepositoryImpl.getAgregatPTAPI(ptId);
      result.fold((failure) => actual = failure, (ptId) => actual = ptId);

      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Pelaporan PT', () {
    String ptId =
        'Qfdsx7wMRWrACnxBeH6uBvpWYFPt6ftJReuw-sEfbFAGr2_X4bMEKR7gxEiVW0z7cPmP0A==';
    final String url = '$urlStagging/pddikti/perguruan_tinggi/$ptId/pelaporan';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_pelaporan_pt/pelaporan_pt.json';
    final expectedResponse =
        GetPelaporanPT.fromJson(jsonDecode(readFile(filePath)));
    test('should return Pelaporan PT with response code 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      var actual;
      final result = await pddiktiDetailRepositoryImpl.getPelaporanPTAPI(ptId);
      result.fold((failure) => actual = failure,
          (getPelaporanPT) => actual = getPelaporanPT);
      expect(actual.data.pelaporan, equals(expectedResponse.data.pelaporan));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      var actual;
      final result = await pddiktiDetailRepositoryImpl.getPelaporanPTAPI(ptId);
      result.fold((failure) => actual = failure,
          (getPelaporanPT) => actual = getPelaporanPT);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Akreditasi PT', () {
    String ptId =
        'Qfdsx7wMRWrACnxBeH6uBvpWYFPt6ftJReuw-sEfbFAGr2_X4bMEKR7gxEiVW0z7cPmP0A==';
    final String url = '$urlStagging/pddikti/perguruan_tinggi/$ptId/akreditasi';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_akreditasi_pt/akreditasi_pt.json';
    final expectedResponse =
        GetAkreditasiPT.fromJson(jsonDecode(readFile(filePath)));
    test('should return Akreditasi PT with response code by 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      var actual;
      final result = await pddiktiDetailRepositoryImpl.getAkreditasiPTAPI(ptId);
      result.fold((failure) => actual = failure,
          (akreditasiPt) => actual = akreditasiPt);
      expect(actual.data.akreditasi[0],
          equals(expectedResponse.data.akreditasi[0]));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      var actual;
      final result = await pddiktiDetailRepositoryImpl.getAkreditasiPTAPI(ptId);
      result.fold((failure) => actual = failure,
          (akreditasiPt) => actual = akreditasiPt);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Detail Prodi', () {
    final String kodePT = '001002';
    final String kodeProdi = '79201';
    final String url =
        '$urlStagging/pddikti/perguruan_tinggi/$kodePT/prodi/$kodeProdi';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_detail_prodi/detail_prodi.json';
    final expectedResponse =
        GetDetailProdi.fromJson(jsonDecode(readFile(filePath)));
    test('should return Detail Prodi with response code by 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiDetailRepositoryImpl.getDetailProdiAPI(
          kodeProdi, kodePT, true);
      var actual;
      result.fold((failure) => actual = failure,
          (getDetailProdi) => actual = getDetailProdi);
      expect(actual.data.prodi.kode, equals(expectedResponse.data.prodi.kode));
      expect(actual.data.prodi.nama, equals(expectedResponse.data.prodi.nama));
      expect(
          actual.data.prodi.status, equals(expectedResponse.data.prodi.status));
      expect(actual.data.prodi.deskripsi,
          equals(expectedResponse.data.prodi.deskripsi));
      expect(actual.data.prodi.visi, equals(expectedResponse.data.prodi.visi));
      expect(actual.data.prodi.misi, equals(expectedResponse.data.prodi.misi));
      expect(actual.data.prodi.kompetensi,
          equals(expectedResponse.data.prodi.kompetensi));
      expect(actual.data.prodi.tglBerdiri,
          equals(expectedResponse.data.prodi.tglBerdiri));
      expect(actual.data.prodi.skSelenggara,
          equals(expectedResponse.data.prodi.skSelenggara));
      expect(actual.data.prodi.tglSkSelenggara,
          equals(expectedResponse.data.prodi.tglSkSelenggara));
      expect(
          actual.data.prodi.jalan, equals(expectedResponse.data.prodi.jalan));
      expect(actual.data.prodi.kelurahan,
          equals(expectedResponse.data.prodi.kelurahan));
      expect(actual.data.prodi.kodePos,
          equals(expectedResponse.data.prodi.kodePos));
      expect(actual.data.prodi.kabKota,
          equals(expectedResponse.data.prodi.kabKota));
      expect(actual.data.prodi.jenjangDidik,
          equals(expectedResponse.data.prodi.jenjangDidik));
      expect(actual.data.prodi.pt.kode,
          equals(expectedResponse.data.prodi.pt.kode));
      expect(actual.data.prodi.pt.nama,
          equals(expectedResponse.data.prodi.pt.nama));
      expect(actual.data.prodi.pt.namaSingkat,
          equals(expectedResponse.data.prodi.pt.namaSingkat));
      expect(actual.data.prodi.telepon,
          equals(expectedResponse.data.prodi.telepon));
      expect(actual.data.prodi.faksimile,
          equals(expectedResponse.data.prodi.faksimile));
      expect(
          actual.data.prodi.email, equals(expectedResponse.data.prodi.email));
      expect(actual.data.prodi.website,
          equals(expectedResponse.data.prodi.website));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiDetailRepositoryImpl.getDetailProdiAPI(
          kodeProdi, kodePT, true);
      var actual;
      result.fold((failure) => actual = failure,
          (getDetailProdi) => actual = getDetailProdi);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Detail Prodi Reg', () {
    late String idReg = "OTA4MzVFRUUtMzYyMy00NjUzLTkyNjMtOUNDNjI1OThDMTNE";
    final String url = "$urlStagging/pddikti/prodi/$idReg";
    final filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_detail_prodi_reg/detail_prodi_reg.json';
    final expected = GetDetailProdiReg.fromJson(jsonDecode(readFile(filePath)));
    test('should return Detail Prodi Reg with response code by 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
      });
      var actual;
      final result =
          await pddiktiDetailRepositoryImpl.getDetailProdiAPIReg(idReg);

      result.fold((failure) => actual = failure, (idReg) => actual = idReg);

      expect(actual.data.prodi[0].kode, equals(expected.data.prodi[0].kode));
      expect(actual.data.prodi[0].nama, equals(expected.data.prodi[0].nama));
      expect(
          actual.data.prodi[0].status, equals(expected.data.prodi[0].status));
      expect(actual.data.prodi[0].deskripsi,
          equals(expected.data.prodi[0].deskripsi));
      expect(actual.data.prodi[0].visi, equals(expected.data.prodi[0].visi));
      expect(actual.data.prodi[0].misi, equals(expected.data.prodi[0].misi));
      expect(actual.data.prodi[0].kompetensi,
          equals(expected.data.prodi[0].kompetensi));
      expect(actual.data.prodi[0].tglBerdiri,
          equals(expected.data.prodi[0].tglBerdiri));
      expect(actual.data.prodi[0].skSelenggara,
          equals(expected.data.prodi[0].skSelenggara));
      expect(actual.data.prodi[0].tglSkSelenggara,
          equals(expected.data.prodi[0].tglSkSelenggara));
      expect(actual.data.prodi[0].kelurahan,
          equals(expected.data.prodi[0].kelurahan));
      expect(
          actual.data.prodi[0].kodePos, equals(expected.data.prodi[0].kodePos));
      expect(
          actual.data.prodi[0].kabKota, equals(expected.data.prodi[0].kabKota));
      expect(actual.data.prodi[0].jenjangDidik,
          equals(expected.data.prodi[0].jenjangDidik));
      expect(actual.data.prodi[0].pt, equals(expected.data.prodi[0].pt));
      expect(
          actual.data.prodi[0].telepon, equals(expected.data.prodi[0].telepon));
      expect(actual.data.prodi[0].faksimile,
          equals(expected.data.prodi[0].faksimile));
      expect(actual.data.prodi[0].email, equals(expected.data.prodi[0].email));
      expect(
          actual.data.prodi[0].website, equals(expected.data.prodi[0].website));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse('$urlStagging/pddikti/prodi/$idReg'),
              headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
      });

      var actual;
      final result =
          await pddiktiDetailRepositoryImpl.getDetailProdiAPIReg(idReg);
      result.fold((failure) => actual = failure, (idReg) => actual = idReg);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get List Dosen Prodi', () {
    final String kodePT = '001002';
    final String kodeProdi = '79201';
    final String url =
        '$urlStagging/pddikti/perguruan_tinggi/$kodePT/prodi/$kodeProdi/dosen';
    final String filePath =
        'dummy_data/pddikti_detail_repository_impl/get_list_dosen_prodi/list_dosen_prodi.json';
    final expectedResponse =
        GetListDosenProdi.fromJson(jsonDecode(readFile(filePath)));
    test('should return List Dosen Prodi with response code by 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiDetailRepositoryImpl.getListDosenProdiAPI(
          kodeProdi, kodePT);
      var actual;
      result.fold((failure) => actual = failure,
          (getListDosenProdi) => actual = getListDosenProdi);
      expect(actual.data.dosen[0].nidn,
          equals(expectedResponse.data.dosen[0].nidn));
      expect(actual.data.dosen[0].nama,
          equals(expectedResponse.data.dosen[0].nama));
      expect(actual.data.dosen[0].gelarDepan,
          equals(expectedResponse.data.dosen[0].gelarDepan));
      expect(actual.data.dosen[0].gelarBelakang,
          equals(expectedResponse.data.dosen[0].gelarBelakang));
      expect(actual.data.dosen[0].pendidikanTerakhir,
          equals(expectedResponse.data.dosen[0].pendidikanTerakhir));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiDetailRepositoryImpl.getListDosenProdiAPI(
          kodeProdi, kodePT);
      var actual;
      result.fold((failure) => actual = failure,
          (getListDosenProdi) => actual = getListDosenProdi);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Rasio Mhs & Dosen', () {
    final String kodePT = '001002';
    final String kodeProdi = '79201';
    final String url =
        '$urlStagging/pddikti/perguruan_tinggi/$kodePT/prodi/$kodeProdi/rasio_dosen_mahasiswa?mulai_tahun=2018&sampai_tahun=2022';
    final String filePath =
        'dummy_data/pddikti_detail_repository_impl/get_rasio_mhs_dosen/rasio_mhs_dosen.json';
    final expectedResponse =
        GetRasioMhsDosen.fromJson(jsonDecode(readFile(filePath)));
    test('should return Rasio Mhs & Dosen', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result =
          await pddiktiDetailRepositoryImpl.getRasioProdiAPI(kodeProdi, kodePT);
      var actual;
      result.fold((failure) => actual = failure,
          (getRasioMhsDosen) => actual = getRasioMhsDosen);
      expect(actual.data.rasio[0], equals(expectedResponse.data.rasio[0]));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result =
          await pddiktiDetailRepositoryImpl.getRasioProdiAPI(kodeProdi, kodePT);
      var actual;
      result.fold((failure) => actual = failure,
          (getRasioMhsDosen) => actual = getRasioMhsDosen);
      expect(actual, equals(ServerFailure('')));
    });
  });

  group('get Akreditasi Prodi', () {
    final String kodePT = '001002';
    final String kodeProdi = '79201';
    final String url =
        '$urlStagging/pddikti/perguruan_tinggi/$kodePT/prodi/$kodeProdi/akreditasi';
    final String filePath =
        '/dummy_data/pddikti_detail_repository_impl/get_akreditasi_pt/akreditasi_pt.json';
    final expectedResponse =
        GetAkreditasiPT.fromJson(jsonDecode(readFile(filePath)));
    test('should return with response code by 200', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await pddiktiDetailRepositoryImpl.getAkreditasiProdiAPI(
          kodeProdi, kodePT);
      var actual;
      result.fold((failure) => actual = failure,
          (getAkreditasiProdi) => actual = getAkreditasiProdi);
      expect(actual.data.akreditasi[0],
          equals(expectedResponse.data.akreditasi[0]));
    });
    test('should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await pddiktiDetailRepositoryImpl.getAkreditasiProdiAPI(
          kodeProdi, kodePT);
      var actual;
      result.fold((failure) => actual = failure,
          (getAkreditasiProdi) => actual = getAkreditasiProdi);
      expect(actual, equals(ServerFailure('')));
    });
  });
}
