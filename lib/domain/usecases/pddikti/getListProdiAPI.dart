import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListProdi.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetListProdiAPI {
  PddiktiRepository repository;

  GetListProdiAPI(this.repository);

  Future<Either<Failure, GetListProdi>> execute(String idPt, String keyword) {
    return repository.getListProdiAPI(idPt, keyword);
  }
}
