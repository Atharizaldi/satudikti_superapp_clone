import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStudi.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetRiwayatStudiMahasiswa {
  PddiktiDetailRepository repository;
  GetRiwayatStudiMahasiswa(this.repository);

  Future<Either<Failure, RiwayatStudiMahasiswa>> execute(
      String nim, String kodePT, String kodePD) async {
    return this.repository.getRiwayatStudiMahasiswaReg(nim, kodePT, kodePD);
  }
}
