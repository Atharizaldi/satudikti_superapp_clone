import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ststusSK.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:dartz/dartz.dart';

class GetPostVerif {
  final IjazahLnRepository repository;

  GetPostVerif(this.repository);

  Future<Either<Failure, VerifikasiSK>> execute(
      String port, String idNegara, String idPT, String nomorSK) {
    return repository.postVerif(port, idNegara, idPT, nomorSK);
  }
}
