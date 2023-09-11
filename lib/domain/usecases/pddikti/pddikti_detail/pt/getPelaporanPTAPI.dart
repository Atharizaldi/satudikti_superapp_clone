import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getPelaporanPT.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetPelaporanPTAPI {
  PddiktiDetailRepository repository;
  GetPelaporanPTAPI(this.repository);

  Future<Either<Failure, GetPelaporanPT>> execute(String ptId) {
    return repository.getPelaporanPTAPI(ptId);
  }
}
