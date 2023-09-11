import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/repositories/sister_repository_impl.dart';
import 'package:app/data/source/remote/model/sister/biodata_sister.dart';
import 'package:app/data/source/remote/model/sister/bkd_rekrutmen_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_diklat_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_formal_dosen_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pembimbingan_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengajaran_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengujian_sister.dart';
import 'package:app/data/source/remote/model/sister/penelitian_sister.dart';
import 'package:app/data/source/remote/model/sister/penempatan_sister.dart';
import 'package:app/data/source/remote/model/sister/pengabdian_sister.dart';
import 'package:app/data/source/remote/model/sister/praktisi_sister.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/bloc/biodata_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/penempatan/bloc/penempatan_sister_bloc.dart';
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
  late SisterRepositoryImpl sisterRepositoryImpl;

  setUp(() async {
    client = MockClient();
    sisterRepositoryImpl = SisterRepositoryImpl(client: client);
  });

  group("Sister Repo Impl", () {
    final String nidn = "0011075807";

    group("get Biodata", () {
      final String url = '$urlAPI/v2/sister/dosen/$nidn';
      final String filePath = "dummy_data/sister/get_biodata.json";
      final expectedDetail =
          BiodataSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Biodata details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getBiodata(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(
            BiodataSisterLoadedState(biodataSister: actual, nidn: nidn),
            equals(BiodataSisterLoadedState(
                biodataSister: expectedDetail, nidn: nidn)));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getBiodata(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Penempatan", () {
      final String url = '$urlAPI/v2/sister/dosen/$nidn/penempatan';
      final String filePath = "dummy_data/sister/get_penempatan.json";
      final expectedDetail =
          PenempatanSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Penempatan details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getPenempatan(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(
            PenempatanSisterLoadedState(penempatanSister: actual, nidn: nidn),
            equals(PenempatanSisterLoadedState(
                penempatanSister: expectedDetail, nidn: nidn)));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getPenempatan(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Pendidikan Formal", () {
      final String url = '$urlAPI/v2/sister/dosen/$nidn/pendidikan/formal';
      final String filePath = "dummy_data/sister/get_pendidikan_formal.json";
      final expectedDetail =
          PendidikanFormalDosenSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Pendidikan formal details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result =
            await sisterRepositoryImpl.getPendidikanFormalDosen(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result =
            await sisterRepositoryImpl.getPendidikanFormalDosen(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Pendidikan Formal", () {
      final String url = '$urlAPI/v2/sister/dosen/$nidn/pendidikan/formal';
      final String filePath = "dummy_data/sister/get_pendidikan_formal.json";
      final expectedDetail =
          PendidikanFormalDosenSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Pendidikan formal details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result =
            await sisterRepositoryImpl.getPendidikanFormalDosen(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result =
            await sisterRepositoryImpl.getPendidikanFormalDosen(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Pendidikan Diklat", () {
      final String judul = "a";
      final String displayBy = "semester-asc";
      final String url =
          '$urlAPI/v2/sister/dosen/$nidn/pendidikan/diklat?judul=$judul&display-by=$displayBy';
      final String filePath = "dummy_data/sister/get_diklat.json";
      final expectedDetail =
          PendidikanDiklatSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Pendidikan Diklat details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getPendidikanDiklat(
            nidn, displayBy, judul);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getPendidikanDiklat(
            nidn, displayBy, judul);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Pendidikan Pengujian", () {
      final String judul = "a";
      final String displayBy = "semester-asc";
      final String nidn1 = "7700007136";
      final String url =
          '$urlAPI/v2/sister/dosen/$nidn/pendidikan/pengujian?judul=$judul&display-by=$displayBy';
      final String filePath = "dummy_data/sister/get_pendidikan_pengujian.json";
      final expectedDetail =
          PendidikanPengujianSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Pendidikan Pengujian details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getPendidikanPengujian(
            nidn, displayBy, judul);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getPendidikanPengujian(
            nidn, displayBy, judul);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Pendidikan Pengajaran", () {
      final String matkul = "a";
      final String displayBy = "semester-asc";
      final String url =
          '$urlAPI/v2/sister/dosen/$nidn/pendidikan/pengajaran?matkul=$matkul&display-by=$displayBy';
      final String filePath =
          "dummy_data/sister/get_pendidikan_pengajaran.json";
      final expectedDetail =
          PendidikanPengajaranSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Pendidikan Pengajaran details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getPendidikanPengajaran(
            nidn, matkul, displayBy);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getPendidikanPengajaran(
            nidn, matkul, displayBy);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Pendidikan Pembimbingan", () {
      final String judul = "a";
      final String displayBy = "semester-asc";
      final String url =
          '$urlAPI/v2/sister/dosen/$nidn/pendidikan/pembimbingan?judul=$judul&display-by=$displayBy';
      final String filePath =
          "dummy_data/sister/get_pendidikan_pembimbingan.json";
      final expectedDetail =
          PendidikanPembimbinganSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Pendidikan pembimbingan details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getPendidikanPembimbingan(
            nidn, displayBy, judul);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getPendidikanPembimbingan(
            nidn, displayBy, judul);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Praktisi", () {
      final String url = '$urlAPI/v2/sister/dosen/$nidn/praktisi';
      final String filePath = "dummy_data/sister/get_praktisi.json";
      final expectedDetail =
          PraktisiSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Praktisi details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getPraktisi(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getPraktisi(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Pengabdian", () {
      final String url = '$urlAPI/v2/sister/dosen/$nidn/pengabdian';
      final String filePath = "dummy_data/sister/get_pengabdian.json";
      final expectedDetail =
          PengabdianSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Pengabdian details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getPengabdian(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getPengabdian(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get Penelitian", () {
      final String url = '$urlAPI/v2/sister/dosen/$nidn/penelitian';
      final String filePath = "dummy_data/sister/get_penelitian.json";

      final expectedDetail =
          PenelitianSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return Penelitian details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getPenelitian(nidn);

        var actual;

        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getPenelitian(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get BKD Penilaian", () {
      final String judul = "a";
      final String sortBy = "semester-asc";

      final String url =
          '$urlAPI/v2/sister/dosen/$nidn/bkd/penilaian?nama=$judul&display-by=$sortBy';
      final String filePath = "dummy_data/sister/get_bkd_penilaian.json";

      final expectedDetail =
          BKDPenilaianSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return BKD Penilaian details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result =
            await sisterRepositoryImpl.getBKDPenilaian(nidn, judul, sortBy);

        var actual;

        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result =
            await sisterRepositoryImpl.getBKDPenilaian(nidn, judul, sortBy);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("Get BKD Rekrutmen", () {
      final String url = '$urlAPI/v2/sister/dosen/$nidn/bkd/rekrutmen';
      final String filePath = "dummy_data/sister/get_bkd_rekrutmen.json";

      final expectedDetail =
          BKDRekrutmenSister.fromJson(jsonDecode(readFile(filePath)));
      test("Should return BKD Rekrutmen Details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await sisterRepositoryImpl.getBKDRekrutmen(nidn);

        var actual;

        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test("Should return server error", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await sisterRepositoryImpl.getBKDRekrutmen(nidn);

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);

        expect(actual, equals(ServerFailure('error500')));
      });
    });
  });
}
