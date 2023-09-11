import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/TracerTable.dart';
import 'package:app/domain/repositories/tracerStatistikRepository.dart';
import 'package:dartz/dartz.dart';

class GetHorizontalTable {
  final StatistikTracerRepository repository;

  GetHorizontalTable(this.repository);

  Future<Either<Failure, TracerTable>> execute(String kodePt) {
    return repository.getHorizontalTable(kodePt);
  }
}
