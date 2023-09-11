import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAkreditasiPT.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetAkreditasiPTAPI {
  PddiktiDetailRepository repository;
  GetAkreditasiPTAPI(this.repository);

  Future<Either<Failure, GetAkreditasiPT>> execute(String ptId) {
    return repository.getAkreditasiPTAPI(ptId);
  }
}
