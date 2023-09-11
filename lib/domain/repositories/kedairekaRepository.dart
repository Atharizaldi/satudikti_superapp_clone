import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kedaireka/kedairekaList.dart';
import 'package:dartz/dartz.dart';

abstract class KedairekaRepository {
  Future<Either<Failure, ModelKedairekaIndustri>> getListKedaireka(
      String limit);

  Future<Either<Failure, ModelKedairekaIndustri>> getListKedairekaPT(
      String limit);
}
