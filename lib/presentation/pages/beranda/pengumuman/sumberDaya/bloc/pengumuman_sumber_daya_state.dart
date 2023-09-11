part of 'pengumuman_sumber_daya_bloc.dart';

abstract class PengumumanSumberDayaState extends Equatable {
  const PengumumanSumberDayaState();
}

class PengumumanLoadingState extends PengumumanSumberDayaState {
  @override
  List<Object> get props => [];
}

class PengumumanErrorState extends PengumumanSumberDayaState {
  @override
  List<Object> get props => [];
}

class PengumumanNoInternetState extends PengumumanSumberDayaState {
  @override
  List<Object> get props => [];
}

class PengumumanLoadedState extends PengumumanSumberDayaState {
  final int page;
  final List<Data> pengumumanList;
  final bool hasReachedMax;

  PengumumanLoadedState({required this.page, required this.pengumumanList, required this.hasReachedMax});

  @override
  List<Object> get props => [pengumumanList];
}