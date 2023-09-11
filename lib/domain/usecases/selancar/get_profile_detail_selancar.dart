import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/selancar/profile_PAK_detail.dart';
import 'package:app/domain/repositories/selancar_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileDetailSelancar {
  final SelancarRepository repository;

  GetProfileDetailSelancar(this.repository);

  Future<Either<Failure, ProfilePAKDetail>> execute(String nidn) {
    return repository.getProfileDetail(nidn);
  }
}
