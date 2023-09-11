import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/domain/repositories/sivilRepository.dart';
import 'package:dartz/dartz.dart';

class GetSearchListPT {
  SivilRepository sivilRepository;

  GetSearchListPT(this.sivilRepository);

  Future<Either<Failure, GetListPT>> execute(String keyword) {
    return sivilRepository.getSearchListPT(keyword);
  }
}
