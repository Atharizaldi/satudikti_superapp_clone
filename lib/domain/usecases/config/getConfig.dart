import 'package:app/data/source/remote/model/config.dart';
import 'package:app/domain/repositories/configRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';

class GetConfig {
  final ConfigRepository repository;

  GetConfig(this.repository);

  Future<Either<Failure, Config>> execute(int moduleId) {
    return repository.getConfigValue(moduleId);
  }
}
