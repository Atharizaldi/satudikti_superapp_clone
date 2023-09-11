part of 'result_spesifik_bloc.dart';

abstract class ResultSpesifikEvent extends Equatable {
  const ResultSpesifikEvent();

  @override
  List<Object> get props => [];
}

class LoadResultSpesifikEvent extends ResultSpesifikEvent {
  final Types type;

  LoadResultSpesifikEvent({required this.type});
  @override
  List<Object> get props => [type];
}

class LoadMahasiswaResultEvent extends ResultSpesifikEvent {
  final int category;
  final String? nomorInduk, nama, kodePT, kodePD;
  const LoadMahasiswaResultEvent(
      {required this.category,
      this.nomorInduk,
      this.nama,
      this.kodePT,
      this.kodePD});
  @override
  List<Object> get props => [];
}

class LoadDosenResultEvent extends ResultSpesifikEvent {
  final int category;
  final String? nomorInduk, nama, kodePT, kodePD;
  const LoadDosenResultEvent(
      {required this.category,
      this.nomorInduk,
      this.nama,
      this.kodePT,
      this.kodePD});
  @override
  List<Object> get props => [];
}

class LoadPTResultEvent extends ResultSpesifikEvent {
  final String kodePT, kodeProvinsi, tipePT;
  const LoadPTResultEvent(
      {required this.kodePT, required this.kodeProvinsi, required this.tipePT});
  @override
  List<Object> get props => [];
}

class LoadProdiResultEvent extends ResultSpesifikEvent {
  final String namaProdi;
  final String? kodePT, akreditasi, jenjang;
  const LoadProdiResultEvent(
      {required this.namaProdi, this.kodePT, this.akreditasi, this.jenjang});

  @override
  List<Object> get props => [];
}
