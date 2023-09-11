import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:app/domain/repositories/selancar_repository.dart';
import 'package:dartz/dartz.dart';

class GetUsulanList {
  final SelancarRepository repository;

  GetUsulanList(this.repository);

  Future<Either<Failure, UsulanList>> execute(String nidn) {
    return repository.getUsulanList(nidn);
  }
}
