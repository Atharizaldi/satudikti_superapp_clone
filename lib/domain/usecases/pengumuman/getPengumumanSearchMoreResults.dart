import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/domain/repositories/pengumumanRepository.dart';
import 'package:dartz/dartz.dart';

class GetPengumumanSearchMoreResults {
  final PengumumanRepository repository;

  GetPengumumanSearchMoreResults(this.repository);

  Future<Either<Failure, PengumumanList>> execute(String keyword, String page) {
    return repository.getPengumumanSearch(keyword, page);
  }
}
