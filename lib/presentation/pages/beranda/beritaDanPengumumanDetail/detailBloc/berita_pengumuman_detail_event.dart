part of 'berita_pengumuman_detail_bloc.dart';

abstract class BeritaPengumumanDetailEvent extends Equatable {
  const BeritaPengumumanDetailEvent();
}

class VideoTapEvent extends BeritaPengumumanDetailEvent {
  final bool isPlaying;

  VideoTapEvent({required this.isPlaying});

  @override
  List<Object> get props => [isPlaying];
}
