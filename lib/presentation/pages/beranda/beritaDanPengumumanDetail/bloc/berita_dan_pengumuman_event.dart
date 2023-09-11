part of 'berita_dan_pengumuman_bloc.dart';

abstract class BeritaDanPengumumanEvent extends Equatable {
  const BeritaDanPengumumanEvent();
}

class GetNewsDetailEvent extends BeritaDanPengumumanEvent {
  final String id;

  GetNewsDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetPengumumanDetailEvent extends BeritaDanPengumumanEvent {
  final String id;

  GetPengumumanDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}
