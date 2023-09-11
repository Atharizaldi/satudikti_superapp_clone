part of 'cerita_kampus_merdeka_bloc.dart';

abstract class CeritaKampusMerdekaState extends Equatable {
  const CeritaKampusMerdekaState();

  @override
  List<Object> get props => [];
}

class CeritaKMNoInternetState extends CeritaKampusMerdekaState {
  final List<ListCKM> listCeritaKampusMerdeka;
  final List<ListCKM> recentCeritaKM;
  final List<ListCKM> popularCeritaKM;
  final List<ListCKM> msibCeritaKM;
  final List<ListCKM> pertukaranMahasiswaCeritaKM;
  final List<ListCKM> kampusMengajarCeritaKM;
  final List<ListCKM> iismaCeritaKM;
  final List<ListCKM> wirausahaCeritaKM;
  final List<ListCKM> praktisiMengajarCeritaKM;
  final List<ListCKM> festivalKMCeritaKM;

  CeritaKMNoInternetState({
    required this.listCeritaKampusMerdeka,
    required this.recentCeritaKM,
    required this.popularCeritaKM,
    required this.msibCeritaKM,
    required this.pertukaranMahasiswaCeritaKM,
    required this.kampusMengajarCeritaKM,
    required this.iismaCeritaKM,
    required this.wirausahaCeritaKM,
    required this.praktisiMengajarCeritaKM,
    required this.festivalKMCeritaKM,
  });

  @override
  List<Object> get props => [
    listCeritaKampusMerdeka,
    recentCeritaKM,
    popularCeritaKM,
    msibCeritaKM,
    pertukaranMahasiswaCeritaKM,
    kampusMengajarCeritaKM,
    iismaCeritaKM,
    wirausahaCeritaKM,
    praktisiMengajarCeritaKM,
    festivalKMCeritaKM
  ];
}

class CeritaKMErrorState extends CeritaKampusMerdekaState {}

class CeritaKMLoadingState extends CeritaKampusMerdekaState {}

class CeritaKMLoadedState extends CeritaKampusMerdekaState {
  final List<ListCKM> listCeritaKampusMerdeka;
  final List<ListCKM> recentCeritaKM;
  final List<ListCKM> popularCeritaKM;
  final List<ListCKM> msibCeritaKM;
  final List<ListCKM> pertukaranMahasiswaCeritaKM;
  final List<ListCKM> kampusMengajarCeritaKM;
  final List<ListCKM> iismaCeritaKM;
  final List<ListCKM> wirausahaCeritaKM;
  final List<ListCKM> praktisiMengajarCeritaKM;
  final List<ListCKM> festivalKMCeritaKM;

  CeritaKMLoadedState({
    required this.listCeritaKampusMerdeka,
    required this.recentCeritaKM,
    required this.popularCeritaKM,
    required this.msibCeritaKM,
    required this.pertukaranMahasiswaCeritaKM,
    required this.kampusMengajarCeritaKM,
    required this.iismaCeritaKM,
    required this.wirausahaCeritaKM,
    required this.praktisiMengajarCeritaKM,
    required this.festivalKMCeritaKM,
  });

  @override
  List<Object> get props => [
    listCeritaKampusMerdeka,
    recentCeritaKM,
    popularCeritaKM,
    msibCeritaKM,
    pertukaranMahasiswaCeritaKM,
    kampusMengajarCeritaKM,
    iismaCeritaKM,
    wirausahaCeritaKM,
    praktisiMengajarCeritaKM,
    festivalKMCeritaKM
  ];
}