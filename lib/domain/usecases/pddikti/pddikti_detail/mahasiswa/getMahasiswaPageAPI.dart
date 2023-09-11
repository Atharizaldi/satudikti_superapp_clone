import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getDetailMahasiswa.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetMahasiswaPageAPI {
  PddiktiDetailRepository repository;
  GetMahasiswaPageAPI(this.repository);

  Future<Either<Failure, GetDetailMahasiswa>> execute(
      String nim, String kodePT, String kodePD) async {
    return this.repository.getMahasiswaPageAPI(nim, kodePT, kodePD);
  }
}
