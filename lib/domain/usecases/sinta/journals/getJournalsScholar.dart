import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsScholar.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetJournalsScholar {
  final SintaRepository repository;

  GetJournalsScholar(this.repository);

  Future<Either<Failure, JournalsScholar>> execute(String id, int items, int page, int order) {
    return repository.getJournalsScholar(id, items, page, order);
  }
}