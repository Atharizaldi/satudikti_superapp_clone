import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/berita/newsDetail.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanDetail.dart';
import 'package:app/domain/usecases/berita/getNewsDetail.dart';
import 'package:app/domain/usecases/pengumuman/getPengumumanDetail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'berita_dan_pengumuman_event.dart';
part 'berita_dan_pengumuman_state.dart';

class BeritaDanPengumumanBloc
    extends Bloc<BeritaDanPengumumanEvent, BeritaDanPengumumanState> {
  GetNewsDetail getNewsDetail;
  GetPengumumanDetail getPengumumanDetail;
  InternetCheck internetCheck;
  Logger log;

  BeritaDanPengumumanBloc(
      {required this.getNewsDetail,
      required this.getPengumumanDetail,
      required this.internetCheck,
      required this.log})
      : super(BeritaDanPengumumanLoadingState()) {
    on<GetNewsDetailEvent>(_getNewsDetail);
    on<GetPengumumanDetailEvent>(_getPengumumanDetail);
  }

  void _getNewsDetail(
      GetNewsDetailEvent event, Emitter<BeritaDanPengumumanState> emit) async {
    log.i("getNewsDetail called");
    bool hasConnection = await internetCheck.hasConnection();
    if (hasConnection) {
      final result = await getNewsDetail.execute(event.id);

      await result.fold(
        (failure) async {
          emit(BeritaDanPengumumanErrorState());
        },
        (newsDetail) async {
          emit(BeritaLoadedState(newsDetail: newsDetail));
        },
      );
    } else {
      emit(BeritaDanPengumumanNoInternetState());
    }
  }

  void _getPengumumanDetail(GetPengumumanDetailEvent event,
      Emitter<BeritaDanPengumumanState> emit) async {
    log.i("getPengumumanDetail called");
    bool hasConnection = await internetCheck.hasConnection();
    if (hasConnection) {
      final result = await getPengumumanDetail.execute(event.id);

      await result.fold(
        (failure) async {
          emit(BeritaDanPengumumanErrorState());
        },
        (pengumumanDetail) async {
          emit(PengumumanLoadedState(pengumumanDetail: pengumumanDetail));
        },
      );
    } else {
      emit(BeritaDanPengumumanNoInternetState());
    }
  }
}
