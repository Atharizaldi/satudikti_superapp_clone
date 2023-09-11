part of 'beranda_bloc.dart';

abstract class BerandaState extends Equatable {
  const BerandaState();

  @override
  List<Object> get props => [];
}

class BerandaNoInternetState extends BerandaState {
  @override
  List<Object> get props => [];
}

class BerandaLoadingState extends BerandaState {
  @override
  List<Object> get props => [];
}

class BerandaErrorState extends BerandaState {
  @override
  List<Object> get props => [];
}

class BerandaLoadedState extends BerandaState {
  final NewsList recentBeritaList;
  final NewsList popularBeritaList;
  final PengumumanList pengumumanList;
  final List<MenuItems> listMenuFavorit;
  final List<MenuItems> listMenuLainnya;

  BerandaLoadedState(
      {required this.recentBeritaList,
      required this.popularBeritaList,
      required this.pengumumanList,
      required this.listMenuFavorit,
      required this.listMenuLainnya});

  @override
  List<Object> get props => [
        recentBeritaList,
        popularBeritaList,
        pengumumanList,
        listMenuFavorit,
        listMenuLainnya
      ];
}
