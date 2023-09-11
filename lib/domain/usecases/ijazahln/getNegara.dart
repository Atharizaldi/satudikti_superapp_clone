import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/negaraIjazahLNList.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:dartz/dartz.dart';

class GetNegara {
  final IjazahLnRepository repository;

  GetNegara(this.repository);

  Future<Either<Failure, NegaraIjazahLNList>> execute(
      String port, String layanan) {
    return repository.getNegara(port);
  }
}
