import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/IjazahLN/status/statusByEmail.dart';
import 'package:app/data/source/remote/model/IjazahLN/status/statusByNoRegis.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/negaraIjazahLNList.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/prodiPTLN.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ptIjazahLNList.dart';
import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ststusSK.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:dartz/dartz.dart';

abstract class IjazahLnRepository {
  Future<Either<Failure, FAQList>> getFaqIjazah(String port, String layanan);

  Future<Either<Failure, StatusByEmail>> getByEmail(
      String port, String keyword);

  Future<Either<Failure, StatusByNoReg>> getByNoReg(
      String port, String keyword);

  Future<Either<Failure, NegaraIjazahLNList>> getNegara(String port);

  Future<Either<Failure, PtIjazahLNList>> getPT(
      String port, String idNegara, String namaUniv);

  Future<Either<Failure, VerifikasiSK>> postVerif(
      String port, String idNegara, String idPT, String nomorSK);

  Future<Either<Failure, ProdiPTLN>> getProdiPTLN(String idPT);
}
