
import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/repositories/beasiswaRepositoryImpl.dart';
import 'package:app/data/repositories/pddiktiRepositoryImpl.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mock_client.mocks.dart';
import '../../json_reader.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late BeasiswaRepositoryImpl beasiswaRepositoryImpl;
  late PddiktiRepositoryImpl pddiktiRepositoryImpl;
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());

  setUp(() {
    client = MockClient();
    beasiswaRepositoryImpl = BeasiswaRepositoryImpl(client: client);
    pddiktiRepositoryImpl = PddiktiRepositoryImpl(client: client);
  });

  group("search list beasiswa", () {
    final String url = "$urlStagging/beasiswa?nama=asus&page=1";
    final String filePath =
        "/dummy_data/beasiswa/search_list/search_list_beasiswa.json";

    final expectedBeasiswa =
        Beasiswa.fromJson(jsonDecode(readFile(filePath)));

    test("should return Beasiswa with response code 200", () async {

      final result1 = await pddiktiRepositoryImpl.getElasticSearch("ammar");
      var actual1;
      result1.fold((failure) => actual1 = failure,
              (beasiswa) => actual1 = beasiswa);

      print(actual1.data.dashboard.mahasiswa[0].idReg);

          when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer((_) async {
            return http.Response(readFile(filePath), 200, headers:{
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
          });

          final result =
              await beasiswaRepositoryImpl.searchListBeasiswa("asus", 1);
          var actual;
          result.fold((failure) => actual = failure,
              (beasiswa) => actual = beasiswa);

          expect(actual.data!.listBeasiswa,
              equals(expectedBeasiswa.data!.listBeasiswa));
        });

      test("should return ServerFailure", () async{
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer((_) async {
          return http.Response(readFile(filePath), 500, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
          });
      final result =
          await beasiswaRepositoryImpl.searchListBeasiswa("asus", 1);
      var actual;
      result.fold((failure) => actual = failure,
          (beasiswa) => actual = beasiswa);
      expect(actual, equals(ServerFailure('')));
    });

  });


  group("search list beasiswa filter", () {
    final String url = "$urlStagging/beasiswa?nama=asus&page=1&penerima=2";
    final String filePath =
        "/dummy_data/beasiswa/search_list_filter/search_list_beasiswa_filter.json";

    final expectedBeasiswaFilter =
    Beasiswa.fromJson(jsonDecode(readFile(filePath)));

    test("should return Beasiswa with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200, headers:{
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
      });
      final result =
      await beasiswaRepositoryImpl.searchListBeasiswaFilter("asus", 1, 2);
      var actual;
      result.fold((failure) => actual = failure,
              (beasiswa) => actual = beasiswa);

      expect(actual.data!.listBeasiswa,
          equals(expectedBeasiswaFilter.data!.listBeasiswa));
    });

    test("should return ServerFailure", () async{
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer((_) async {
        return http.Response(readFile(filePath), 500, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
      });
      final result =
      await beasiswaRepositoryImpl.searchListBeasiswaFilter("asus", 1, 2);
      var actual;
      result.fold((failure) => actual = failure,
              (beasiswa) => actual = beasiswa);

      expect(actual, equals(ServerFailure('')));
    });

  });

  group('get list beasiswa open', () {
    final String url = "$urlStagging/beasiswa?is_open=true&page=1";
    final String filePath = "/dummy_data/beasiswa/list_beasiswa/list_open.json";
    final expectedOpenListProgram =
    Beasiswa.fromJson(jsonDecode(readFile(filePath)));

    test("should return ListBeasiswa with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
      });
      final result =
      await beasiswaRepositoryImpl.getListBeasiswaSedangDibuka(1);
      var actual;
      result.fold((failure) => actual = failure,
              (openBeasiswa) => actual = openBeasiswa);

      expect(actual.data!.listBeasiswa,
          equals(expectedOpenListProgram.data!.listBeasiswa));
    });

    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
      });
      final result =
      await beasiswaRepositoryImpl.getListBeasiswaSedangDibuka(1);
      var actual;
      result.fold((failure) => actual = failure,
              (openBeasiswa) => actual = openBeasiswa);
      expect(actual, equals(ServerFailure('internalServer500')));
      print(actual.toString());
    });
  });

  group('get list beasiswa closed', () {
    final String url = "$urlStagging/beasiswa?is_open=false&page=1";
    final String filePath =
        "/dummy_data/beasiswa/list_beasiswa/list_closed.json";
    final expectedClosedListProgram =
    Beasiswa.fromJson(jsonDecode(readFile(filePath)));

    test("should return ListBeasiswa with response code 200", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
      });
      final result =
      await beasiswaRepositoryImpl.getListBeasiswaSedangDitutup(1);
      var actual;
      result.fold((failure) => actual = failure,
              (closedBeasiswa) => actual = closedBeasiswa);

      expect(actual.data!.listBeasiswa,
          equals(expectedClosedListProgram.data!.listBeasiswa));
    });

    test("should return ServerFailure", () async {
      when(client.get(Uri.parse(url), headers: appHeaders))
          .thenAnswer((_) async {
        return http.Response(readFile(filePath), 500, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
      });
      final result =
      await beasiswaRepositoryImpl.getListBeasiswaSedangDitutup(1);
      var actual;
      result.fold((failure) => actual = failure,
              (closedBeasiswa) => actual = closedBeasiswa);
      expect(actual, equals(ServerFailure('internalServer500')));
    });
  });
}


