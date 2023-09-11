import 'dart:convert';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/repositories/tracerStatistikRepositoryImpl.dart';
import 'package:app/data/source/remote/model/tracer/TracerPie.dart';
import 'package:app/domain/repositories/tracerStatistikRepository.dart';
import 'package:dartz/dartz.dart';
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
  late StatistikTracerRepository repository;

  setUp(() {
    client = MockClient();
    repository = StatistikTracerRepositoryImpl(client: client);
  });

  group("Statistik Tracer Repository", () {
    test("Should return horizontal pie chart data", () async {
      final String kodePt = "001002";
      final String url = '$urlAPI/v2/tracer/statistik/keselarasan/pie/$kodePt';
      final String filePath = "dummy_data/statistic_tracer/horizontal_pie.json";
      final expectedResponse = jsonDecode(readFile(filePath));

      when(client.get(Uri.parse(url))).thenAnswer((_) async {
        return http.Response(readFile(filePath), 200);
      });

      final result = await repository.getHorizontalPieChart(kodePt);

      expect(result, equals(Right(TracerPie.fromJson(expectedResponse))));
    });

    test("Should return ServerFailure when status code is not 200", () async {
      final String kodePt = "001002";
      final String url = '$urlAPI/v2/tracer/statistik/keselarasan/pie/$kodePt';

      when(client.get(Uri.parse(url))).thenAnswer((_) async {
        return http.Response('', 500);
      });

      final result = await repository.getHorizontalPieChart(kodePt);

      expect(result, equals(Left(ServerFailure('internalServer500'))));
    });

    test("Should return ConnectionFailure on SocketException", () async {
      final String kodePt = "001002";
      final String url = '$urlAPI/v2/tracer/statistik/keselarasan/pie/$kodePt';

      when(client.get(Uri.parse(url))).thenThrow(SocketException(''));

      final result = await repository.getHorizontalPieChart(kodePt);

      expect(result, equals(Left(ConnectionFailure(''))));
    });
  });
}
