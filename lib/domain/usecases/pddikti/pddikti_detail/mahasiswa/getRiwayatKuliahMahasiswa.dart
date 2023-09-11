import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStatusKuliah.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetRiwayatKuliahMahasiswa {
  PddiktiDetailRepository repository;
  GetRiwayatKuliahMahasiswa(this.repository);

  Future<Either<Failure, RiwayatStatusKuliah>> execute(
      String nim, String kodePT, String kodePD) async {
    return this.repository.getRiwayatKuliahMahasiswa(nim, kodePT, kodePD);
  }
}
