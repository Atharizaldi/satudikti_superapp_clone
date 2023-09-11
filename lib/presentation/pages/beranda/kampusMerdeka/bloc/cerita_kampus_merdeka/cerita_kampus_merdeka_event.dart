part of 'cerita_kampus_merdeka_bloc.dart';

abstract class CeritaKampusMerdekaEvent extends Equatable {
  const CeritaKampusMerdekaEvent();

  @override
  List<Object> get props => [];
}

class GetCeritaKMRecentlyEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMPopularEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMMSIBEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMPertukaranMahasiswaEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMKampusMengajarEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMKampusMerdekaEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMIISMAEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMWirausahaEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMPraktisiMengajarEvent extends CeritaKampusMerdekaEvent {}

class GetCeritaKMFestivalKampusMerdekaEvent extends CeritaKampusMerdekaEvent {}
