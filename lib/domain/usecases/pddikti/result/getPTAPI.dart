import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getSpecificElasticPT.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetPTAPI {
  PddiktiRepository repository;
  GetPTAPI(this.repository);

  Future<Either<Failure, GetSpecificElasticPT>> execute(
      String npsn, String kodeProvinsi, String tipePT) {
    return repository.getPTAPI(npsn, kodeProvinsi, tipePT);
  }
}
