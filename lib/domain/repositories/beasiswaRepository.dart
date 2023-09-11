import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:dartz/dartz.dart';

abstract class BeasiswaRepository {
  Future<Either<Failure, Beasiswa>> getListBeasiswaSedangDibuka(int page);
  Future<Either<Failure, Beasiswa>> getListBeasiswaSedangDitutup(int page);
  Future<Either<Failure, Beasiswa>> getListBeasiswaAkanDibuka(int page);
  Future<Either<Failure, Beasiswa>> searchListBeasiswa(
      String keyword, int page);
  Future<Either<Failure, Beasiswa>> searchListBeasiswaClosed(
      String keyword, int page);
  Future<Either<Failure, Beasiswa>> searchListBeasiswaFilter(
      String keyword, int page, int penerima);
}
