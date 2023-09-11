import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/domain/repositories/pengumumanRepository.dart';
import 'package:dartz/dartz.dart';

class GetPengumumanWithCategory {
  final PengumumanRepository repository;

  GetPengumumanWithCategory(this.repository);

  Future<Either<Failure, PengumumanList>> execute(String page, String limit, String kategori) {
    return repository.getPengumumanWithCategory(page, limit, kategori);
  }
}
