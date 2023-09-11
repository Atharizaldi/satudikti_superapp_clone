part of 'pengumuman_pembelajaran_bloc.dart';

abstract class PengumumanPembelajaranState extends Equatable {
  const PengumumanPembelajaranState();
}

class PengumumanLoadingState extends PengumumanPembelajaranState {
  @override
  List<Object> get props => [];
}

class PengumumanErrorState extends PengumumanPembelajaranState {
  @override
  List<Object> get props => [];
}

class PengumumanNoInternetState extends PengumumanPembelajaranState {
  @override
  List<Object> get props => [];
}

class PengumumanLoadedState extends PengumumanPembelajaranState {
  final int page;
  final List<Data> pengumumanList;
  final bool hasReachedMax;

  PengumumanLoadedState({required this.page, required this.pengumumanList, required this.hasReachedMax});

  @override
  List<Object> get props => [pengumumanList];
}

