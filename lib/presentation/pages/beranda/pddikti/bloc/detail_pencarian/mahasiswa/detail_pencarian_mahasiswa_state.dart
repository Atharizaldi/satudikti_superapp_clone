part of 'detail_pencarian_mahasiswa_bloc.dart';

abstract class DetailPencarianMahasiswaState extends Equatable {
  const DetailPencarianMahasiswaState();

  @override
  List<Object> get props => [];
}

class InitDetailState extends DetailPencarianMahasiswaState {}

class NoInternetState extends DetailPencarianMahasiswaState {}

class LoadedDetailState extends DetailPencarianMahasiswaState {}
