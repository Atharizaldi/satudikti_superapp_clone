import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/garuda/garudaPaper.dart';
import 'package:app/domain/repositories/garudaRepository.dart';
import 'package:dartz/dartz.dart';

class SearchGarudaPaper {
  final GarudaRepository repository;

  SearchGarudaPaper(this.repository);

  Future<Either<Failure, GarudaPaper>> execute(String keyword, int page) {
    return repository.searchGarudaPaper(keyword, page);
  }
}
