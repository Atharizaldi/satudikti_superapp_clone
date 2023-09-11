import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/siaga/detailTrackingUsulan.dart';
import 'package:app/domain/repositories/siagaRepository.dart';
import 'package:dartz/dartz.dart';

class GetDetailTrackingUsulan{
  SiagaRepository siagaRepository;

  GetDetailTrackingUsulan(this.siagaRepository);

  Future<Either<Failure, StatusPengajuanUsulan>> execute(String
  kataKunci) {
    return siagaRepository.getDetailTrackingUsulan(kataKunci);
  }
}