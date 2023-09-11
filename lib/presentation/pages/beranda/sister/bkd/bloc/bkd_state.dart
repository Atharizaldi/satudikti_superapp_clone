part of 'bkd_bloc.dart';

abstract class BKDSisterState extends Equatable {
  const BKDSisterState();

  @override
  List<Object> get props => [];
}

class BKDSisterInitial extends BKDSisterState {}

class BKDSisterLoading extends BKDSisterState {}

class BKDSisterLoadedState extends BKDSisterState {
  late final String nidn;
  late final List<BKDRekrutmenData> bkdRekrutmenData;
  late final List<BKDPenilaianData> bkdPenilaianData;
  late final String judul;
  late final String sortBy;

  BKDSisterLoadedState(
      {required this.nidn,
      required this.bkdRekrutmenData,
      required this.bkdPenilaianData,
      required this.judul,
      required this.sortBy});

  @override
  List<Object> get props => [bkdRekrutmenData, bkdPenilaianData];
}

class BKDSisterNoInternetState extends BKDSisterState {
  final String nidn;

  BKDSisterNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class BKDSisterErrorState extends BKDSisterState {
  final String nidn;

  BKDSisterErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class BKDSisterNotFoundState extends BKDSisterState {
  final BKDPenilaianSister? bkdPenilaianSister;
  final BKDRekrutmenSister? bkdRekrutmenSister;

  BKDSisterNotFoundState(this.bkdRekrutmenSister, this.bkdPenilaianSister);

  @override
  List<Object> get props => [];
}
