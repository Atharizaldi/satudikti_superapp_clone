import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/pengabdian_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPengabdianSister {
  final SisterRepository repository;

  GetPengabdianSister(this.repository);

  Future<Either<Failure, PengabdianSister>> execute(String nidn) {
    return repository.getPengabdian(nidn);
  }
}
