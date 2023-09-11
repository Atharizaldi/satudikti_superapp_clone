import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/domain/repositories/pengumumanRepository.dart';
import 'package:dartz/dartz.dart';

class GetPengumumanSearch {
  final PengumumanRepository repository;

  GetPengumumanSearch(this.repository);

  Future<Either<Failure, PengumumanList>> execute(String keyword) {
    return repository.getPengumumanSearch(keyword, '1');
  }
}
