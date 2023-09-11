
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/ckm_list.dart';
import 'package:app/domain/repositories/kampusMerdekaRepository.dart';
import 'package:dartz/dartz.dart';

class GetCKM {
  final KampusMerdekaRepository repository;

  GetCKM(this.repository);

  Future<Either<Failure,CeritaKampusMerdeka>> execute(String category){
    return repository.getCKM(category);
  }
}