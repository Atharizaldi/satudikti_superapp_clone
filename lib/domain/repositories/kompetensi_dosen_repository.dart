import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/daftarUnduhan.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/penilaian_dosen.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/programTerdaftar.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/sertifikat.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/tawaranProgram.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/unduhan.dart';
import 'package:dartz/dartz.dart';

abstract class KompetensiDosenRepository {
  Future<Either<Failure, TawaranProgramResponse>> getListTawaranProgram();
  Future<Either<Failure, DaftarUnduhanResponse>> getFileList();
  Future<Either<Failure, PenilaianDosen>> getPenilaianDosen(String id);
  Future<Either<Failure, ProgramTerdaftarResponse>> getProgramTerdaftar(
      String nidn, String tahun);
  Future<Either<Failure, Sertifikat>> getSertifikat(String id);
  Future<Either<Failure, Unduhan>> getUnduhan(String id);
  Future<void> downloadSertifikat(String id);
  Future<void> downloadUnduhan(String id);
}
