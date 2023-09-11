part of 'berita_pengumuman_detail_bloc.dart';

abstract class BeritaPengumumanDetailState extends Equatable {
  const BeritaPengumumanDetailState();
}

class VideoState extends BeritaPengumumanDetailState {
  final bool isPlaying;

  VideoState({this.isPlaying = false});

  @override
  List<Object> get props => [isPlaying];
}
