import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getDetailDosen.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatMengajar.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatPendidikan.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getDetailMahasiswa.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getDetailMahasiswaReg.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStatusKuliah.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStudi.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAgregatPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAkreditasiPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getDetailPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getPelaporanPT.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getDetailProdi.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getDetailProdiReg.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListDosenProdi.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getRasioMhsDosen.dart';
import 'package:dartz/dartz.dart';

abstract class PddiktiDetailRepository {
  Future<Either<Failure, GetDetailMahasiswa>> getMahasiswaPageAPI(
      String nim, String kodePT, String kodePD);

  Future<Either<Failure, GetDetailMahasiswaReg>> getMahasiswaPageAPIReg(
      String nim);

  Future<Either<Failure, RiwayatStatusKuliah>> getRiwayatKuliahMahasiswa(
      String nim, String kodePT, String kodePD);

  Future<Either<Failure, RiwayatStudiMahasiswa>> getRiwayatStudiMahasiswaReg(
      String nim, String kodePT, String kodePD);

  Future<Either<Failure, GetDetailDosen>> getDetailDosenPageAPI(String nidn);

  Future<Either<Failure, RiwayatPendidikan>> getRiwayatPendidikanDosenAPI(
      String nidn);

  Future<Either<Failure, RiwayatMengajar>> getRiwayatMengajarDosenAPI(
      String nidn);

  Future<Either<Failure, GetDetailPT>> getDetailPTAPI(String kodePT);

  Future<Either<Failure, GetAgregatPT>> getAgregatPTAPI(String ptId);

  Future<Either<Failure, GetPelaporanPT>> getPelaporanPTAPI(String ptId);

  Future<Either<Failure, GetAkreditasiPT>> getAkreditasiPTAPI(String ptId);

  Future<Either<Failure, GetDetailProdi>> getDetailProdiAPI(
      String kodeProdi, String kodePT, bool fromPT);

  Future<Either<Failure, GetDetailProdiReg>> getDetailProdiAPIReg(String idReg);

  Future<Either<Failure, GetListDosenProdi>> getListDosenProdiAPI(
      String kodeProdi, String kodePT);

  Future<Either<Failure, GetRasioMhsDosen>> getRasioProdiAPI(
      String kodeProdi, String kodePT);

  Future<Either<Failure, GetAkreditasiPT>> getAkreditasiProdiAPI(
      String kodeProdi, String kodePT);
}
