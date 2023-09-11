import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/config.dart';
import 'package:dartz/dartz.dart';

abstract class ConfigRepository {
  Future<Either<Failure, Config>> getConfigValue(int moduleId);
}
