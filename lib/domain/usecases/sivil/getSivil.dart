import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sivil/sivilList.dart';
import 'package:app/domain/repositories/sivilRepository.dart';
import 'package:dartz/dartz.dart';

class GetSivil {
  SivilRepository sivilRepository;

  GetSivil(this.sivilRepository);

  Future<Either<Failure, Sivil>> execute(String kodePt, kodeProdi, noIjazah) {
    return sivilRepository.getSivil(kodePt, kodeProdi, noIjazah);
  }
}
