import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/repositories/gmagzRepositoryImpl.dart';
import 'package:app/data/source/remote/model/gmagz/downloader_gmagz.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_detail_gmagz.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_gmagz.dart';
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
  late GMagzRepositoryImpl gMagzRepositoryImpl;

  setUp(() async {
    client = MockClient();
    gMagzRepositoryImpl = GMagzRepositoryImpl(client: client);
  });

  group("Testing all gmagz repo impl", () {
    final String rating = "true";
    final String judul = "menawan";
    final String displayby = "majalah-rilis-asc";
    final String page = "1";
    final String id = "fd1a3bca-f9e5-44e7-a5d9-05c915e0ce30";

    group("get all majalah", () {
      final String url =
          '$urlAPI/v2/gmagz/books?rating=$rating&judul=$judul&display-by=$displayby&page=$page';
      final String filePath = "dummy_data/gmagz/get_all_majalah.json";
      final expectedDetail =
          MajalahGMagz.fromJson(jsonDecode(readFile(filePath)));
      test("Should return all majalah details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await gMagzRepositoryImpl.getMajalah(
            rating, judul, displayby, int.parse(page));
        var actual;
        result.fold((l) => actual = l = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test('should return ServerFailure', () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await gMagzRepositoryImpl.getMajalah(
            rating, judul, displayby, int.parse(page));
        var actual;
        result.fold(
            (failure) => actual = failure, (getDetail) => actual = getDetail);
        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("get all majalah", () {
      final String url = '$urlAPI/v2/gmagz/books/$id';
      final String filePath = "dummy_data/gmagz/get_majalah_details.json";
      final expectedDetail =
          MajalahDetailGMagz.fromJson(jsonDecode(readFile(filePath)));
      test("Should return majalah details", () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await gMagzRepositoryImpl.getMajalahDetail(id);
        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test('should return ServerFailure', () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 500);
        });
        final result = await gMagzRepositoryImpl.getMajalahDetail(id);
        var actual;
        result.fold(
            (failure) => actual = failure, (getDetail) => actual = getDetail);
        expect(actual, equals(ServerFailure('error500')));
      });
    });

    group("put download majalah", () {
      final String url = '$urlAPI/v2/gmagz/books/$id/download';
      final String filePath = "dummy_data/gmagz/put_download_majalah.json";
      final expectedDetail =
          DownloaderGMagz.fromJson(jsonDecode(readFile(filePath)));
      test("Should return put download success", () async {
        when(client.put(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await gMagzRepositoryImpl.putDownloader(id);
        var actual;

        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      // test('should return ServerFailure', () async {
      //   when(client.put(Uri.parse(url), headers: appHeaders))
      //       .thenAnswer((_) async {
      //     return http.Response(readFile(filePath), 500);
      //   });
      //   final result = await gMagzRepositoryImpl.putDownloader(id);
      //   var actual;
      //   result.fold(
      //       (failure) => actual = failure, (getDetail) => actual = getDetail);
      //   expect(actual, equals(ServerFailure('')));
      // });
    });

    group("put Read majalah", () {
      final String url = '$urlAPI/v2/gmagz/books/$id/read';
      final String filePath = "dummy_data/gmagz/put_read_majalah.json";
      final expectedDetail =
          DownloaderGMagz.fromJson(jsonDecode(readFile(filePath)));
      test("Should return put read success", () async {
        when(client.put(Uri.parse(url), headers: appHeaders))
            .thenAnswer((_) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await gMagzRepositoryImpl.putReader(id);
        var actual;

        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      // test('should return ServerFailure', () async {
      //   when(client.put(Uri.parse(url), headers: appHeaders))
      //       .thenAnswer((_) async {
      //     return http.Response(readFile(filePath), 500);
      //   });
      //   final result = await gMagzRepositoryImpl.putReader(id);
      //   var actual;
      //   result.fold(
      //       (failure) => actual = failure, (getDetail) => actual = getDetail);
      //   expect(actual, equals(ServerFailure('')));
      // });
    });
  });
}
