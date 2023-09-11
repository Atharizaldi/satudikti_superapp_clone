import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perubahan_dosen_tendik/model_perubahan_dosen_tendik.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetPerubahanDosenDanTendik {
  PddiktiRepository repository;
  GetPerubahanDosenDanTendik(this.repository);

  Future<Either<Failure, PerubahanDosenTendikResponse>> execute(
      String nidn, int page) async {
    return this.repository.listUDosenDanTendik(nidn, page);
  }
}
