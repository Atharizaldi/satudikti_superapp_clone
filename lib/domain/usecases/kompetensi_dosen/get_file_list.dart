import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/daftarUnduhan.dart';
import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';
import 'package:dartz/dartz.dart';

class GetFileList {
  final KompetensiDosenRepository repository;
  GetFileList(this.repository);

  Future<Either<Failure, DaftarUnduhanResponse>> execute() {
    return repository.getFileList();
  }
}
