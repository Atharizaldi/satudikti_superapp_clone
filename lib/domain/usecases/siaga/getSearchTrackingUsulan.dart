import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/siaga/searchTracking.dart';
import 'package:app/domain/repositories/siagaRepository.dart';
import 'package:dartz/dartz.dart';

class GetSearchTrackingUsulan{
  SiagaRepository siagaRepository;
  GetSearchTrackingUsulan(this.siagaRepository);

  Future<Either<Failure, SearchTrackingUsulan>> execute(String keyword) {
    return siagaRepository.getSearchTrackingUsulan(keyword);
  }
}