import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsDetail.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:dartz/dartz.dart';

class GetJournalsDetail {
  final SintaRepository repository;

  GetJournalsDetail(this.repository);

  Future<Either<Failure, JournalsDetail>> execute(String id) {
    return repository.getJournalsDetail(id);
  }
}