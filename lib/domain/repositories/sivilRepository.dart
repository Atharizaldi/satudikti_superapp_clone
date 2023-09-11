import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListProdi.dart';
import 'package:app/data/source/remote/model/sivil/sivilList.dart';
import 'package:dartz/dartz.dart';

abstract class SivilRepository {
  Future<Either<Failure, GetListPT>> getSearchListPT(String keyword);

  Future<Either<Failure, GetListProdi>> getSearchListProdi(
      String idPt, String keyword);

  Future<Either<Failure, Sivil>> getSivil( String kodePt, kodeProdi, noIjazah);
}
