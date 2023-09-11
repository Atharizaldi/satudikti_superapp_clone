import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/modul.dart';
import 'package:dartz/dartz.dart';

abstract class ModulRepository {
  Future<Either<Failure, AutoGenerate>> getModulSearch(String keyword);
}
