part of 'detail_pencarian_dosen_bloc.dart';

abstract class DetailPencarianDosenEvent extends Equatable {
  const DetailPencarianDosenEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailPencarianDosenEvent extends DetailPencarianDosenEvent {
  final String nama, nomorInduk, namaProdi, namaPT;
  final String? kodePD;

  LoadDetailPencarianDosenEvent(
    this.kodePD, {
    required this.nama,
    required this.nomorInduk,
    required this.namaProdi,
    required this.namaPT,
  });

  @override
  List<Object> get props => [nama, nomorInduk, namaProdi, namaPT];
}
