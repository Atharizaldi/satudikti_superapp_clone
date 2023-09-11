import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsList.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetJournalsList {
  final SintaRepository repository;

  GetJournalsList(this.repository);

  Future<Either<Failure, JournalsList>> execute(int items, int page, int order, String q) {
    return repository.getJournalsList(items, page, order, q);
  }
}