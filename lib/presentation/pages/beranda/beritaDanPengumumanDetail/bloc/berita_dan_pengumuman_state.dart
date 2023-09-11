part of 'berita_dan_pengumuman_bloc.dart';

abstract class BeritaDanPengumumanState extends Equatable {
  const BeritaDanPengumumanState();
}

class BeritaDanPengumumanLoadingState extends BeritaDanPengumumanState {
  @override
  List<Object> get props => [];
}

class BeritaDanPengumumanErrorState extends BeritaDanPengumumanState {
  @override
  List<Object> get props => [];
}

class BeritaDanPengumumanNoInternetState extends BeritaDanPengumumanState {
  @override
  List<Object> get props => [];
}

class BeritaLoadedState extends BeritaDanPengumumanState {
  final NewsDetail newsDetail;

  BeritaLoadedState({required this.newsDetail});

  @override
  List<Object> get props => [newsDetail];
}

class PengumumanLoadedState extends BeritaDanPengumumanState {
  final PengumumanDetail pengumumanDetail;

  PengumumanLoadedState({required this.pengumumanDetail});

  @override
  List<Object> get props => [pengumumanDetail];
}
