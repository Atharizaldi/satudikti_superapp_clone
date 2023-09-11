import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/domain/repositories/selancar_repository.dart';
import 'package:dartz/dartz.dart';

class GetUsulanDetail {
  final SelancarRepository repository;

  GetUsulanDetail(this.repository);

  Future<Either<Failure, UsulanDetail>> execute(String nidn, String id) {
    return repository.getUsulanDetail(nidn, id);
  }
}
