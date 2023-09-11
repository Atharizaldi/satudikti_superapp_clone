import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/programTerdaftar.dart';
import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';
import 'package:dartz/dartz.dart';

class GetProgramTerdaftar {
  final KompetensiDosenRepository repository;
  GetProgramTerdaftar(this.repository);

  Future<Either<Failure, ProgramTerdaftarResponse>> execute(
      String nidn, String tahun) {
    return repository.getProgramTerdaftar(nidn, tahun);
  }
}
