import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/tawaranProgram.dart';
import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';
import 'package:dartz/dartz.dart';

class GetListTawaranProgram {
  final KompetensiDosenRepository repository;
  GetListTawaranProgram(this.repository);

  Future<Either<Failure, TawaranProgramResponse>> execute() {
    return repository.getListTawaranProgram();
  }
}
