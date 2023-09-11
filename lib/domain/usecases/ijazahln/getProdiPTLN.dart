import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/prodiPTLN.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:dartz/dartz.dart';

class GetProdiPTLN {
  final IjazahLnRepository repository;

  GetProdiPTLN(this.repository);

  Future<Either<Failure, ProdiPTLN>> execute(String idPT) {
    return repository.getProdiPTLN(idPT);
  }
}
