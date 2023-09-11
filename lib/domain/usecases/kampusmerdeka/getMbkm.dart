import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/MBKMList.dart';
import 'package:app/domain/repositories/kampusMerdekaRepository.dart';
import 'package:dartz/dartz.dart';

class GetMBKM {
  final KampusMerdekaRepository repository;

  GetMBKM(this.repository);

  Future<Either<Failure, MBKMList>> execute() {
    return repository.getMBKMApi();
  }
}
