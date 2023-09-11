import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
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

  setUp(() async {
    client = MockClient();
  });

  group("Get Province Test", () {
    final String url = '$urlAPI/v2/tracer/provinsi';
    final String filePath = "dummy_data/tracer_study/get_provinsi.json";
    final expectedResponse = jsonDecode(readFile(filePath));

    test("Should return dummy provinsi data", () async {
      when(client.get(Uri.parse(url))).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });

      final response = await client.get(Uri.parse(url));
      final actualResponse = jsonDecode(response.body);

      expect(actualResponse, equals(expectedResponse));
    });
  });

  group("Get Kabupaten Test", () {
    late MockClient client;

    setUp(() async {
      client = MockClient();
    });

    test("Should return kabupaten data", () async {
      final String kodeProvinsi = "20000";
      final String url =
          '$urlAPI/v2/tracer/kabupaten?kode_provinsi=$kodeProvinsi';
      final String filePath = "dummy_data/tracer_study/get_kabupaten.json";
      final expectedResponse = jsonDecode(readFile(filePath));

      when(client.get(Uri.parse(url))).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });

      final response = await client.get(Uri.parse(url));
      final actualResponse = jsonDecode(response.body);

      expect(actualResponse, equals(expectedResponse));
    });
  });

  group("Get Tracer List PT Test", () {
    late MockClient client;

    setUp(() async {
      client = MockClient();
    });

    test("Should return tracer list PT data", () async {
      final String keyword = "Universitas Indonesia";
      final String url = '$urlAPI/v2/tracer/perguruan_tinggi/$keyword';
      final String filePath = "dummy_data/tracer_study/get_tracerlist_pt.json";
      final expectedResponse = jsonDecode(readFile(filePath));

      when(client.get(Uri.parse(url))).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });

      final response = await client.get(Uri.parse(url));
      final actualResponse = jsonDecode(response.body);

      expect(actualResponse, equals(expectedResponse));
    });
  });

  group("Get Tracer List Prodi Test", () {
    late MockClient client;

    setUp(() async {
      client = MockClient();
    });

    test("Should return tracer list Prodi data", () async {
      final String kodePt = "001002";
      final String keyword = "informasi";
      final String url =
          '$urlAPI/v2/tracer/prodi?kode_pt=$kodePt&search=$keyword';
      final String filePath =
          "dummy_data/tracer_study/get_tracerlist_prodi.json";
      final expectedResponse = jsonDecode(readFile(filePath));

      when(client.get(Uri.parse(url))).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });

      final response = await client.get(Uri.parse(url));
      final actualResponse = jsonDecode(response.body);

      expect(actualResponse, equals(expectedResponse));
    });
  });

  group("Get All Answer Test", () {
    late MockClient client;

    setUp(() async {
      client = MockClient();
    });

    test("Should return all answer data", () async {
      final String id = "1d17f31f-440e-418f-8e81-27346be98bcf";
      final String url = '$urlAPI/v2/tracer/answers/$id';
      final String filePath = "dummy_data/tracer_study/get_all_answer.json";
      final expectedResponse = jsonDecode(readFile(filePath));

      when(client.get(Uri.parse(url))).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });

      final response = await client.get(Uri.parse(url));
      final actualResponse = jsonDecode(response.body);

      expect(actualResponse, equals(expectedResponse));
    });
  });
}
