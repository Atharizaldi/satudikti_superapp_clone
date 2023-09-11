import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/IDPTPDDIKTI.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetIDPTPDDIKTI {
  PddiktiRepository repository;

  GetIDPTPDDIKTI(this.repository);

  Future<Either<Failure, IDPTPDDIKTI>> execute(String id) {
    return repository.getIDPTPDDIKTI(id);
  }
}
