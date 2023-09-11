import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/profile_sister_detail.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileDetailSister {
  final SisterRepository repository;

  GetProfileDetailSister(this.repository);

  Future<Either<Failure, ProfileSisterDetail>> execute(String nidn) {
    return repository.getProfileDetail(nidn);
  }
}
