import 'package:app/data/source/remote/model/tracer/AnswerKuesioner.dart';
import 'package:app/data/source/remote/model/tracer/getAllAnswer.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListKabupaten.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListPT.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListProdi.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListProvinsi.dart';
import 'package:app/data/source/remote/model/tracer/postStoreAnswer.dart';
import 'package:app/data/source/remote/model/tracer/validasiData.dart';
import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../data/source/remote/model/tracer/TracerKuesioner.dart';

abstract class KuesionerTracerRepository {
  Future<Either<Failure, List<Question>>> getQuestions(int page);
  Future<Either<Failure, ValidasiData>> validateData(
      String kodePt, String kodeProdi, String nim, String tglLahir, String nik);
  Future<Either<Failure, GetTracerListProvinsi>> getTracerListProvinsiSearch(
      String keyword);
  Future<Either<Failure, Map<String, String>>> getListElasticProvinsitracer();
  Future<Either<Failure, List<Kabupaten>>> getListElasticKabupatenTracer(
      String kodeProv);
  Future<Either<Failure, List<DataPtTracer>>> getTracerListPt(String keyword);
  Future<Either<Failure, List<DataProdiTracer>>> getTracerListProdi(
      String kodePt, String keyword);
  Future<Either<Failure, PostStoreAnswerData>> postStoreAnswer(
      List<AnswerKuesioner> listAnswer);
  Future<Either<Failure, GetAllAnswer>> getAllAnswer(String id);
}
