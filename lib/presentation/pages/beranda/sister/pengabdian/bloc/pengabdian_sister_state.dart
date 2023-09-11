part of 'pengabdian_sister_bloc.dart';

abstract class PengabdianSisterState extends Equatable {
  const PengabdianSisterState();

  @override
  List<Object> get props => [];
}

class PengabdianSisterinInitial extends PengabdianSisterState {}

class PengabdianSisterLoadedState extends PengabdianSisterState {
  final List<PengabdianData> pengabdianData;
  final String nidn;

  PengabdianSisterLoadedState(
      {required this.nidn, required this.pengabdianData});

  @override
  List<Object> get props => [pengabdianData];
}

class PengabdianSisterLoadedStateOne extends PengabdianSisterState {
  final List<PengabdianData> pengabdianData;
  final String nidn;

  PengabdianSisterLoadedStateOne(
      {required this.nidn, required this.pengabdianData});

  @override
  List<Object> get props => [pengabdianData];
}

class PengabdianSisterNoInternetState extends PengabdianSisterState {
  final String nidn;

  PengabdianSisterNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class PengabdianSisterErrorState extends PengabdianSisterState {
  final String nidn;

  PengabdianSisterErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class PengabdianSisterNotFoundState extends PengabdianSisterState {
  final PengabdianSister? pengabdianSister;
  PengabdianSisterNotFoundState(this.pengabdianSister);

  @override
  List<Object> get props => [];
}
