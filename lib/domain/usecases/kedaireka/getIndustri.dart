import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kedaireka/kedairekaList.dart';
import 'package:app/domain/repositories/kedairekaRepository.dart';
import 'package:dartz/dartz.dart';

class GetListIndustri {
  final KedairekaRepository repository;

  GetListIndustri(this.repository);

  Future<Either<Failure, ModelKedairekaIndustri>> execute(String limit) {
    return repository.getListKedaireka(limit);
  }
}
