import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/praktisi_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPraktisiSister{
  final SisterRepository repository;
  GetPraktisiSister(this.repository);

  Future<Either<Failure, PraktisiSister>> execute(String nidn){
    return repository.getPraktisi(nidn);
  }
}