import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListProvinsi.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';

class GetListProvinsi {
  KuesionerTracerRepository repository;
  GetListProvinsi(this.repository);

  Future<Either<Failure, GetTracerListProvinsi>> execute(String keyword) {
    return repository.getTracerListProvinsiSearch(keyword);
  }
}