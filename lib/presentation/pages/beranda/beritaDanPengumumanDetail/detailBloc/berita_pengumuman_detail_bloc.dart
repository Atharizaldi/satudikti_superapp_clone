import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'berita_pengumuman_detail_event.dart';
part 'berita_pengumuman_detail_state.dart';

class BeritaPengumumanDetailBloc
    extends Bloc<BeritaPengumumanDetailEvent, BeritaPengumumanDetailState> {
  Logger log;

  BeritaPengumumanDetailBloc({required this.log}) : super(VideoState()) {
    on<VideoTapEvent>(_videoTap);
  }

  void _videoTap(
      VideoTapEvent event, Emitter<BeritaPengumumanDetailState> emit) async {
    emit(VideoState(isPlaying: event.isPlaying));
  }
}
