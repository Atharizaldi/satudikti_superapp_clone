import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/elasticSearch.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetElasticSearch {
  PddiktiRepository repository;
  GetElasticSearch(this.repository);

  Future<Either<Failure, ElasticSearch>> execute(String keyword) async {
    return this.repository.getElasticSearch(keyword);
  }
}
