import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/repositories/kampus_merdeka_repository_impl.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/MBKMList.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/ckm_list.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/detail_ckm.dart';
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
  late KampusMerdekaRepositoryImpl kmImpl;

  setUp(() async {
    client = MockClient();
    kmImpl = KampusMerdekaRepositoryImpl(client: client);
  });

  group('Kampus Merdeka Repo Impl', () {
    group('get Program', () {
      final String url = 'https://devsuperapp-api.dikti.go.id/v2/mbkm/program';
      final String filePath = 'dummy_data/kampus_merdeka/get_program.json';
      final expectedDetail = MBKMList.fromJson(jsonDecode(readFile(filePath)));

      test('Should return Program MBKM', () async {
        when(client.get(Uri.parse(url), headers: appHeaders))
            .thenAnswer((realInvocation) async {
          return http.Response(readFile(filePath), 200);
        });
        final result = await kmImpl.getMBKMApi();

        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(expectedDetail));
      });

      test('Should return server error', () async {
        when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer(
            (realInvocation) async => http.Response(readFile(filePath), 500));
        final result = await kmImpl.getMBKMApi();
        var actual;
        result.fold((l) => actual = l, (r) => actual = r);
        expect(actual, equals(ServerFailure('error500')));
      });
    });
  });

  group('get Cerita Kampus Merdeka List', () {
    final String category = '7';
    final String url = '$urlAPI/v2/mbkm/cerita/$category';
    final String filePath = 'dummy_data/kampus_merdeka/get_ckm.json';
    final expectedDetail =
        CeritaKampusMerdeka.fromJson(jsonDecode(readFile(filePath)));

    test('Should return all cerita kampus merdeka', () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer(
          (realInvocation) async => http.Response(readFile(filePath), 200));
      final result = await kmImpl.getCKM(category);
      var actual;
      result.fold((l) => actual = l, (r) => actual = r);
      expect(actual, equals(expectedDetail));
    });

    test('Should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer(
          (realInvocation) async => http.Response(readFile(filePath), 500));
      final result = await kmImpl.getCKM(category);
      var actual;
      result.fold(
          (failure) => actual = failure, (getDetail) => actual = getDetail);
      expect(actual, equals(ServerFailure('error500')));
    });
  });

  group('get Cerita Kampus Merdeka detail', () {
    final String id = '133';
    final String url = '$urlAPI/v2/mbkm/cerita/detail/$id';
    final String filePath = 'dummy_data/kampus_merdeka/get_detail_ckm.json';
    final expectedDetail =
        DetailCeritaKampusMerdeka.fromJson(jsonDecode(readFile(filePath)));

    test('Should return cerita kampus merdeka detail', () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer(
          (realInvocation) async => http.Response(readFile(filePath), 200));
      final result = await kmImpl.getDetailCKM(id);
      var actual;
      result.fold((l) => actual = l, (r) => actual = r);
      expect(actual, equals(expectedDetail));
    });

    test('Should return ServerFailure', () async {
      when(client.get(Uri.parse(url), headers: appHeaders)).thenAnswer(
          (realInvocation) async => http.Response(readFile(filePath), 500));
      final result = await kmImpl.getDetailCKM(id);
      var actual;
      result.fold(
          (failure) => actual = failure, (getDetail) => actual = getDetail);
      expect(actual, equals(ServerFailure('error500')));
    });
  });
}
