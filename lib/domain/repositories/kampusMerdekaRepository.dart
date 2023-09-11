import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/MBKMList.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/ckm_list.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/detail_ckm.dart';
import 'package:dartz/dartz.dart';

abstract class KampusMerdekaRepository {
  Future<Either<Failure, MBKMList>> getMBKMApi();

  /// Cerita Kampus Merdeka

  /// Get All Cerita Kampus Merdeka
  Future<Either<Failure, CeritaKampusMerdeka>> getCKM(String category);

  /// Get Detail Cerita Kampus Merdeka
  Future<Either<Failure, DetailCeritaKampusMerdeka>> getDetailCKM(String id);
}
