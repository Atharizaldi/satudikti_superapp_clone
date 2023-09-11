import 'package:equatable/equatable.dart';

abstract class KuesionerTracerEvent extends Equatable {
  const KuesionerTracerEvent();
}

class GetKuesionerTracerEvent extends KuesionerTracerEvent {
  final int? page;

  GetKuesionerTracerEvent(this.page);

  @override
  List<Object> get props => [];
}

class PostValidateDataEvent extends KuesionerTracerEvent {
  final String kodePt;
  final String kodeProdi;
  final String nim;
  final String tglLahir;
  final String nik;

  PostValidateDataEvent(
      {required this.kodePt,
      required this.kodeProdi,
      required this.nim,
      required this.tglLahir,
      required this.nik});
  @override
  List<Object> get props => [];
}

class GetAnswer extends KuesionerTracerEvent {
  final String id;
  GetAnswer({required this.id});
  @override
  List<Object> get props => [];
}
