import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/data/source/remote/model/selancar/profile_PAK_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:dartz/dartz.dart';

abstract class SelancarRepository {
  Future<Either<Failure, FAQList>> getFAQSelancar();
  Future<Either<Failure, ProfilePAKDetail>> getProfileDetail(String nidn);
  Future<Either<Failure, UsulanList>> getUsulanList(String nidn);
  Future<Either<Failure, UsulanDetail>> getUsulanDetail(String nidn, String id);
}
