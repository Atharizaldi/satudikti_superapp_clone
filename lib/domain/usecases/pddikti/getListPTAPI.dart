import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetListPTAPI {
  PddiktiRepository repository;

  GetListPTAPI(this.repository);

  Future<Either<Failure, GetListPT>> execute(
      String page, String limit, String keyword) {
    return repository.getListPTAPI(page, limit, keyword);
  }
}
