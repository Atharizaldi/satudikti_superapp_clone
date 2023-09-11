import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ptIjazahLNList.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:dartz/dartz.dart';

class GetPT {
  final IjazahLnRepository repository;

  GetPT(this.repository);

  Future<Either<Failure, PtIjazahLNList>> execute(
      String port, String idNegara, String namaUniv) {
    return repository.getPT(port, idNegara, namaUniv);
  }
}
