import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getDetailProdiReg.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetDetailProdiAPIReg {
  PddiktiDetailRepository repository;
  GetDetailProdiAPIReg(this.repository);

  Future<Either<Failure, GetDetailProdiReg>> execute(String idReg) {
    return repository.getDetailProdiAPIReg(idReg);
  }
}
