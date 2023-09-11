import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanDetail.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:dartz/dartz.dart';

abstract class PengumumanRepository {
  Future<Either<Failure, PengumumanList>> getPengumuman(
    String page,
    String limit,
  );
  Future<Either<Failure, PengumumanDetail>> getPengumumanDetail(
    String id,
  );
  Future<Either<Failure, PengumumanList>> getPengumumanWithCategory(
    String page,
    String limit,
    String kategori,
  );

  Future<Either<Failure, PengumumanList>> getPengumumanSearch(
    String title,
    String page,
  );
}
