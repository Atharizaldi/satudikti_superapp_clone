import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/TracerPie.dart';
import 'package:app/domain/repositories/tracerStatistikRepository.dart';
import 'package:dartz/dartz.dart';

class GetPekerjaanDibawahEnamBulanPieChart {
  final StatistikTracerRepository repository;

  GetPekerjaanDibawahEnamBulanPieChart(this.repository);

  Future<Either<Failure, TracerPie>> execute(String kodePt) {
    return repository.getPekerjaanDibawahEnamBulanPieChart(kodePt);
  }
}
