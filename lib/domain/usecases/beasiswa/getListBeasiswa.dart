import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:app/domain/repositories/beasiswaRepository.dart';
import 'package:dartz/dartz.dart';

class GetListBeasiswa {
  final BeasiswaRepository repository;

  GetListBeasiswa(this.repository);

  Future<Either<Failure, Beasiswa>> execute(int page) {
    return repository.getListBeasiswaSedangDibuka(page);
  }
}

class GetListBeasiswaSedangDitutup {
  final BeasiswaRepository repository;

  GetListBeasiswaSedangDitutup(this.repository);

  Future<Either<Failure, Beasiswa>> execute(int page) {
    return repository.getListBeasiswaSedangDitutup(page);
  }

}

class GetListBeasiswaAkanDibuka {
  final BeasiswaRepository repository;

  GetListBeasiswaAkanDibuka(this.repository);

  Future<Either<Failure, Beasiswa>> execute(int page) {
    return repository.getListBeasiswaAkanDibuka(page);
  }

}
