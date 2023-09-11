import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/data/source/remote/model/siaga/detailTrackingUsulan.dart';
import 'package:app/data/source/remote/model/siaga/searchTracking.dart';
import 'package:dartz/dartz.dart';

abstract class SiagaRepository {
  Future<Either<Failure, FAQList>> getFaqSiaga();
  Future<Either<Failure, SearchTrackingUsulan>> getSearchTrackingUsulan
      (String keyword);
  Future<Either<Failure, StatusPengajuanUsulan>> getDetailTrackingUsulan
      (String kataKunci);
}