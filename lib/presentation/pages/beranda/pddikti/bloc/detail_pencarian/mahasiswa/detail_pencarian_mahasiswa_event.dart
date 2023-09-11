part of 'detail_pencarian_mahasiswa_bloc.dart';

abstract class DetailPencarianMahasiswaEvent extends Equatable {
  const DetailPencarianMahasiswaEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailPencarianEvent extends DetailPencarianMahasiswaEvent {
  final String nama, nomorInduk, kodePT, kodePD, namaProdi, namaPT;
  final bool fromElasticGeneral;

  LoadDetailPencarianEvent(
      {required this.nama,
      required this.nomorInduk,
      required this.kodePT,
      required this.kodePD,
      required this.namaProdi,
      required this.namaPT,
      required this.fromElasticGeneral});

  @override
  List<Object> get props =>
      [nama, nomorInduk, kodePT, kodePD, namaProdi, namaPT, fromElasticGeneral];
}
