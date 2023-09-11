import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/modul.dart';
import 'package:app/domain/repositories/modulRepository.dart';
import 'package:dartz/dartz.dart';

class GetModul {
  final ModulRepository repository;

  GetModul(this.repository);

  Future<Either<Failure, AutoGenerate>> execute(String keyword) {
    return repository.getModulSearch(keyword);
  }
}
