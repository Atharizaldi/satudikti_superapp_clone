import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getSpecificMahasiswa.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetDetailMahasiswaAPI {
  PddiktiRepository repository;
  GetDetailMahasiswaAPI(this.repository);

  Future<Either<Failure, GetSpecificMahasiswa>> execute(
      String nama, String nim, String kodePT, String kodePD) {
    return repository.getDetailMahasiswaAPI(nama, nim, kodePT, kodePD);
  }
}
