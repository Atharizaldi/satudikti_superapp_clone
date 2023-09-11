import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/biodata_sister.dart';
import 'package:app/data/source/remote/model/sister/bkd_rekrutmen_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_diklat_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_formal_dosen_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pembimbingan_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengajaran_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengujian_sister.dart';
import 'package:app/data/source/remote/model/sister/penelitian_sister.dart';
import 'package:app/data/source/remote/model/sister/penempatan_sister.dart';
import 'package:app/data/source/remote/model/sister/pengabdian_sister.dart';
import 'package:app/data/source/remote/model/sister/praktisi_sister.dart';
import 'package:app/data/source/remote/model/sister/profile_sister_detail.dart';
import 'package:dartz/dartz.dart';

abstract class SisterRepository {
  Future<Either<Failure, ProfileSisterDetail>> getProfileDetail(String nidn);

  Future<Either<Failure, PenempatanSister>> getPenempatan(String nidn);

  Future<Either<Failure, BiodataSister>> getBiodata(String nidn);

  Future<Either<Failure, PraktisiSister>> getPraktisi(String nidn);

  Future<Either<Failure, PendidikanFormalDosenSister>> getPendidikanFormalDosen(
      String nidn);

  Future<Either<Failure, PendidikanDiklatSister>> getPendidikanDiklat(
      String nidn, String displayBy, String judul);

  Future<Either<Failure, PendidikanPengujianSister>> getPendidikanPengujian(
      String nidn, String displayBy, String judul);

  Future<Either<Failure, PendidikanPengajaranSister>> getPendidikanPengajaran(
      String nidn, String displayBy, String matkul);

  Future<Either<Failure, PendidikanPembimbinganSister>>
      getPendidikanPembimbingan(String nidn, String displayBy, String judul);

  Future<Either<Failure, PengabdianSister>> getPengabdian(String nidn);

  Future<Either<Failure, PenelitianSister>> getPenelitian(String nidn);

  Future<Either<Failure, BKDRekrutmenSister>> getBKDRekrutmen(String nidn);

  Future<Either<Failure, BKDPenilaianSister>> getBKDPenilaian(
      String nidn, String judul, String sortBy);
}
