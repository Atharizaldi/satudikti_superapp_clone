import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/status_usulan_dosen/usulan_dosen.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetUsulanDosen {
  PddiktiRepository repository;

  GetUsulanDosen(this.repository);

  Future<Either<Failure, UsulanDosenResponse>> execute(String namaDosen,
      String tanggalLahir, String idPT, String nidn, String isLogin) async {
    return this
        .repository
        .getUsulanDosen(namaDosen, tanggalLahir, idPT, nidn, isLogin);
  }
}
