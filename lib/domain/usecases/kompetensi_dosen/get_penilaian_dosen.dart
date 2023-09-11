import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/penilaian_dosen.dart';
import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';
import 'package:dartz/dartz.dart';

class GetPenilaianDosen {
  final KompetensiDosenRepository repository;
  GetPenilaianDosen(this.repository);

  Future<Either<Failure, PenilaianDosen>> execute(String id) {
    return repository.getPenilaianDosen(id);
  }
}
