import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/unduhan.dart';
import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';
import 'package:dartz/dartz.dart';

class GetUnduhan {
  final KompetensiDosenRepository repository;
  GetUnduhan(this.repository);

  Future<Either<Failure, Unduhan>> execute(String id) {
    return repository.getUnduhan(id);
  }
}
