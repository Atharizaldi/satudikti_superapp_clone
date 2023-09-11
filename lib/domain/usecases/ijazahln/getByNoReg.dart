import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/IjazahLN/status/statusByNoRegis.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:dartz/dartz.dart';

class GetByNoReg {
  final IjazahLnRepository repository;

  GetByNoReg(this.repository);

  Future<Either<Failure, StatusByNoReg>> execute(String port, String keyword) {
    return repository.getByNoReg(port, keyword);
  }
}
