part of 'pengumuman_kelembagaan_bloc.dart';

abstract class PengumumanKelembagaanState extends Equatable {
  const PengumumanKelembagaanState();
}

class PengumumanLoadingState extends PengumumanKelembagaanState {
  @override
  List<Object> get props => [];
}

class PengumumanErrorState extends PengumumanKelembagaanState {
  @override
  List<Object> get props => [];
}

class PengumumanNoInternetState extends PengumumanKelembagaanState {
  @override
  List<Object> get props => [];
}

class PengumumanLoadedState extends PengumumanKelembagaanState {
  final int page;
  final List<Data> pengumumanList;
  final bool hasReachedMax;

  PengumumanLoadedState({required this.page, required this.pengumumanList, required this.hasReachedMax});

  @override
  List<Object> get props => [pengumumanList];
}