part of 'detail_pencarian_dosen_bloc.dart';

abstract class DetailPencarianDosenState extends Equatable {
  const DetailPencarianDosenState();

  @override
  List<Object> get props => [];
}

class InitDetailDosenState extends DetailPencarianDosenState {}

class NoInternetState extends DetailPencarianDosenState {}

class LoadedDetailState extends DetailPencarianDosenState {}
