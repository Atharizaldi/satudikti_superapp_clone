import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanDetail.dart';
import 'package:app/domain/repositories/pengumumanRepository.dart';
import 'package:dartz/dartz.dart';

class GetPengumumanDetail {
  final PengumumanRepository repository;

  GetPengumumanDetail(this.repository);

  Future<Either<Failure, PengumumanDetail>> execute(String id) {
    return repository.getPengumumanDetail(id);
  }
}
