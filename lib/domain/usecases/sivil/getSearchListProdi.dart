import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListProdi.dart';
import 'package:app/domain/repositories/sivilRepository.dart';
import 'package:dartz/dartz.dart';

class GetSearchListProdi {
  SivilRepository sivilRepository;

  GetSearchListProdi(this.sivilRepository);

  Future<Either<Failure, GetListProdi>> execute(String idPt, String keyword) {
    return sivilRepository.getSearchListProdi(idPt, keyword);
  }
}
