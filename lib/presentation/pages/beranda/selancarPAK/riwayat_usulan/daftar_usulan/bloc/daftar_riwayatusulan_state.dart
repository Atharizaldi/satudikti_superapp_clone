part of 'daftar_riwayatusulan_bloc.dart';

abstract class DaftarRiwayatusulanState extends Equatable {
  const DaftarRiwayatusulanState();

  @override
  List<Object> get props => [];
}

class DaftarRiwayatusulanInitial extends DaftarRiwayatusulanState {}

class DaftarRiwayatusulanLoadedState extends DaftarRiwayatusulanState {
  final List<Usulan> usulanList;
  final List<UsulanDetail> usulanDetail;
  final String nidn;

  DaftarRiwayatusulanLoadedState({
    required this.usulanList,
    required this.usulanDetail,
    required this.nidn,
  });

  @override
  List<Object> get props => [this.usulanDetail, this.nidn];
}

class DaftarRiwayatusulanNoInternetState extends DaftarRiwayatusulanState {
  final List<Usulan> usulanList;
  final String nidn;

  DaftarRiwayatusulanNoInternetState({
    required this.usulanList,
    required this.nidn,
  });

  @override
  List<Object> get props => [this.nidn];
}

class DaftarRiwayatusulanErrorState extends DaftarRiwayatusulanState {
  final List<Usulan> usulanList;
  final String nidn;

  DaftarRiwayatusulanErrorState({
    required this.usulanList,
    required this.nidn,
  });

  @override
  List<Object> get props => [this.nidn];
}
