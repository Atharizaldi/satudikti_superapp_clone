import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/sertifikat.dart';
import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';
import 'package:dartz/dartz.dart';

class GetSertifikat {
  final KompetensiDosenRepository repository;
  GetSertifikat(this.repository);

  Future<Either<Failure, Sertifikat>> execute(String id) {
    return repository.getSertifikat(id);
  }
}
