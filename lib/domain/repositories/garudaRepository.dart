import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/data/source/remote/model/garuda/garudaPaper.dart';
import 'package:app/data/source/remote/model/garuda/statistikGaruda.dart';
import 'package:dartz/dartz.dart';

abstract class GarudaRepository {
  Future<Either<Failure, Garuda>> getListJournal(int page);
  Future<Either<Failure, GarudaPaper>> searchGarudaPaper(
      String keyword, int page);
  Future<Either<Failure, Garuda>> searchGarudaJournal(String keyword, int page);
  Future<Either<Failure, Garuda>> searchGarudaJournalBySubject(
      String keyword, String id, int page);
  Future<Either<Failure, ModelStatistikGaruda>> listStatistikGaruda();
}
