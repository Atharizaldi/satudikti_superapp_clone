import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getSpecificDosen.dart';
import 'package:app/data/source/remote/model/pddikti/elasticSearch.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getSpecificMahasiswa.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/IDPTPDDIKTI.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListProdi.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getSpecificElasticPT.dart';
import 'package:app/data/source/remote/model/pddikti/perubahan_dosen_tendik/model_perubahan_dosen_tendik.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getSpecificElasticProdi.dart';
import 'package:app/data/source/remote/model/pddikti/status_usulan_dosen/usulan_dosen.dart';
import 'package:app/data/source/remote/model/tableau.dart';
import 'package:dartz/dartz.dart';

abstract class PddiktiRepository {
  Future<Either<Failure, Tableau>> getStatistic();
  Future<Either<Failure, IDPTPDDIKTI>> getIDPTPDDIKTI(String id);
  Future<Either<Failure, GetListPT>> getListPTAPI(
      String page, String limit, String keyword);
  Future<Either<Failure, GetListProdi>> getListProdiAPI(
      String idPt, String keyword);
  Future<Either<Failure, GetSpecificElasticPT>> getListElasticPTAPI(
      String keyword);
  Future<Either<Failure, Map<String, String>>> getListElasticProvinsi();
  Future<Either<Failure, ElasticSearch>> getElasticSearch(String keyword);
  Future<Either<Failure, GetSpecificElasticPT>> getPTAPI(
      String npsn, String kodeProvinsi, String tipePT);
  Future<Either<Failure, GetSpecificElasticProdi>> getProdiAPI(
      String namaProdi, String kodePT, String akreditasi, String jenjang);
  Future<Either<Failure, GetSpecificMahasiswa>> getDetailMahasiswaAPI(
      String nama, String nim, String kodePT, String kodePD);
  Future<Either<Failure, GetSpecificDosen>> getDetailDosenAPI(
      String nama, String nidn, String kodePT);
  Future<Either<Failure, UsulanDosenResponse>> getUsulanDosen(String namaDosen,
      String tanggalLahir, String idPT, String nidn, String isLogin);
  Future<Either<Failure, PerubahanDosenTendikResponse>> listUDosenDanTendik(
      String nidn, int page);
}
