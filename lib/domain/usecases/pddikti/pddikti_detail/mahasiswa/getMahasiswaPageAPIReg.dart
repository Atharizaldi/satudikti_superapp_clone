import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getDetailMahasiswaReg.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetMahasiswaPageAPIReg {
  PddiktiDetailRepository repository;
  GetMahasiswaPageAPIReg(this.repository);

  Future<Either<Failure, GetDetailMahasiswaReg>> execute(String nim) async {
    return this.repository.getMahasiswaPageAPIReg(nim);
  }
}
