import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/repositories/kompetensi_dosen_repository_impl.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/daftarUnduhan.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/penilaian_dosen.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/sertifikat.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/tawaranProgram.dart';
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
  late KompetensiDosenRepositoryImpl kompetensiDosenRepositoryImpl;

  setUp(() {
    client = MockClient();
    kompetensiDosenRepositoryImpl =
        KompetensiDosenRepositoryImpl(client: client);
  });

  group("get file list", () {
    final String url = "$urlStagging/kompetensi/tawaran/list";
    final String filePath =
        "/dummy_data/kompetensi_dosen/tawaran_program/tawaran_program.json";
    final expectedTawaranProgram =
        TawaranProgramResponse.fromJson(jsonDecode(readFile(filePath)));
    test("should return TawaranProgramResponse with response code 200",
        () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result =
          await kompetensiDosenRepositoryImpl.getListTawaranProgram();
      var actual;
      result.fold((failure) => actual = failure,
          (tawaranProgram) => actual = tawaranProgram);

      expect(actual.data!.listTawaranProgram,
          equals(expectedTawaranProgram.data!.listTawaranProgram));
      // expect(actual.message, equals(expectedTawaranProgram.message));
    });

    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result =
          await kompetensiDosenRepositoryImpl.getListTawaranProgram();
      var actual;
      result.fold((failure) => actual = failure,
          (tawaranProgram) => actual = tawaranProgram);
      expect(actual, equals(ServerFailure("")));
    });
  });

  group("get file list", () {
    final String url = "$urlStagging/kompetensi/file/list";
    final String filePath =
        "/dummy_data/kompetensi_dosen/file_list/file_list.json";
    final expectedFileList =
        DaftarUnduhanResponse.fromJson(jsonDecode(readFile(filePath)));
    test("should return FileList with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await kompetensiDosenRepositoryImpl.getFileList();
      var actual;
      result.fold(
          (failure) => actual = failure, (fileList) => actual = fileList);

      expect(actual.data!.listDaftarUnduhan,
          equals(expectedFileList.data!.listDaftarUnduhan));
      expect(actual.message, equals(expectedFileList.message));
    });

    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await kompetensiDosenRepositoryImpl.getFileList();
      var actual;
      result.fold(
          (failure) => actual = failure, (fileList) => actual = fileList);
      expect(actual, equals(ServerFailure("")));
    });
  });

  group("get penilaian dosen by id", () {
    final String id = "10414";
    final String url = "$urlStagging/kompetensi/program/penilaian";
    final String filePath =
        "/dummy_data/kompetensi_dosen/penilaian_dosen/penilaian_dosen.json";
    final expectedFileList =
        PenilaianDosen.fromJson(jsonDecode(readFile(filePath)));
    test("should return PenilaianDosen with response code 200", () async {
      when(client.get(Uri.parse("$url/$id"), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await kompetensiDosenRepositoryImpl.getPenilaianDosen(id);
      var actual;

      result.fold((failure) => actual = failure,
          (penilaianDosen) => actual = penilaianDosen);

      expect(actual.data, equals(expectedFileList.data));
      expect(actual.message, equals(expectedFileList.message));
    });

    test("should return ServerFailure", () async {
      when(client.get(Uri.parse("$url/$id"), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await kompetensiDosenRepositoryImpl.getPenilaianDosen(id);
      var actual;
      result.fold((failure) => actual = failure,
          (penilaianDosen) => actual = penilaianDosen);
      expect(actual, equals(ServerFailure("")));
    });
  });

  group("get sertifikat by id", () {
    final String id = "10414";
    final String url = "$urlStagging/kompetensi/sertifikat";
    final String filePath = "/dummy_data/general/dummy.pdf";
    final expectedResponse = Sertifikat.fromJson(readFile(filePath));
    test("should return Sertifikat with response code 200", () async {
      when(client.get(Uri.parse(
        "https://kompetensi.sumberdaya.kemdikbud.go.id/web/downloadfile/34"
        ), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await kompetensiDosenRepositoryImpl.getSertifikat(id);
      var actual;

      result.fold(
          (failure) => actual = failure, (sertifikat) => actual = sertifikat);
      expect(actual.file, equals(expectedResponse.file));
    });

    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(
      "https://kompetensi.sumberdaya.kemdikbud.go.id/web/downloadfile/34"
      ), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await kompetensiDosenRepositoryImpl.getSertifikat(id);
      var actual;
      result.fold(
          (failure) => actual = failure, (sertifikat) => actual = sertifikat);
      expect(actual, equals(ServerFailure("")));
    });
  });

  group("get unduhan by id", () {
    final String id = "10414";
    final String url = "$urlStagging/kompetensi/file/unduh";
    final String filePath = "/dummy_data/general/dummy.pdf";
    final expectedResponse = Sertifikat.fromJson(readFile(filePath));
    test("should return Unduhan with response code 200", () async {
      when(client.get(Uri.parse("$url/$id"), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });
      final result = await kompetensiDosenRepositoryImpl.getUnduhan(id);
      var actual;

      result.fold((failure) => actual = failure, (unduhan) => actual = unduhan);
      expect(actual.file, equals(expectedResponse.file));
    });

    test("should return ServerFailure", () async {
      when(client.get(Uri.parse("$url/$id"), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 500);
      });
      final result = await kompetensiDosenRepositoryImpl.getUnduhan(id);
      var actual;
      result.fold((failure) => actual = failure, (unduhan) => actual = unduhan);
      expect(actual, equals(ServerFailure("")));
    });
  });
}
