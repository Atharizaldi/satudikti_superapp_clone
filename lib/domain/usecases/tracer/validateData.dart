import 'package:app/common/failure.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../data/source/remote/model/tracer/validasiData.dart';

class PostValidateData {
  final KuesionerTracerRepository repository;

  PostValidateData(this.repository);

  Future<Either<Failure, ValidasiData>> execute(String kodePt, String kodeProdi,
      String nim, String tglLahir, String nik) {
    return repository.validateData(kodePt, kodeProdi, nim, tglLahir, nik);
  }
}
