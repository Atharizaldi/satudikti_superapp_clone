import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/TracerPie.dart';
import 'package:app/data/source/remote/model/tracer/TracerTable.dart';
import 'package:dartz/dartz.dart';

abstract class StatistikTracerRepository {
  Future<Either<Failure, TracerPie>> getHorizontalPieChart(String kodePt);
  Future<Either<Failure, TracerPie>> getVerticalPieChart(String kodePt);
  Future<Either<Failure, TracerPie>> getPekerjaanDibawahEnamBulanPieChart(
      String kodePt);
  Future<Either<Failure, TracerTable>> getHorizontalTable(String kodePt);
  Future<Either<Failure, TracerTable>> getVerticalTable(String kodePt);
  Future<Either<Failure, TracerTable>> getPekerjaanTable(String kodePt);
}
