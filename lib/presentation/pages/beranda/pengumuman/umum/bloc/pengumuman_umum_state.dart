part of 'pengumuman_umum_bloc.dart';

abstract class PengumumanUmumState extends Equatable {
  const PengumumanUmumState();
}

class PengumumanLoadingState extends PengumumanUmumState {
  @override
  List<Object> get props => [];
}

class PengumumanErrorState extends PengumumanUmumState {
  @override
  List<Object> get props => [];
}

class PengumumanNoInternetState extends PengumumanUmumState {
  @override
  List<Object> get props => [];
}

class PengumumanLoadedState extends PengumumanUmumState {
  final int page;
  final List<Data> pengumumanList;
  final bool hasReachedMax;

  PengumumanLoadedState({required this.page, required this.pengumumanList, required this.hasReachedMax});

  @override
  List<Object> get props => [page, pengumumanList, hasReachedMax];
}

