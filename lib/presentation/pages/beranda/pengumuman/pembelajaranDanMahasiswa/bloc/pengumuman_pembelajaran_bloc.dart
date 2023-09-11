import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/domain/usecases/pengumuman/getPengumumanWithCategory.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/kategoriNumber.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'pengumuman_pembelajaran_event.dart';
part 'pengumuman_pembelajaran_state.dart';

class PengumumanPembelajaranBloc
    extends Bloc<PengumumanPembelajaranEvent, PengumumanPembelajaranState> {
  GetPengumumanWithCategory getPengungumanWithCategory;
  Logger log;
  InternetCheck internetCheck;

  PengumumanPembelajaranBloc(
      {required this.getPengungumanWithCategory,
      required this.log,
      required this.internetCheck})
      : super(PengumumanLoadingState()) {
    on<GetPengumumanPembelajaranEvent>(_getPengumuman);
  }

  void _getPengumuman(GetPengumumanPembelajaranEvent event,
      Emitter<PengumumanPembelajaranState> emit) async {
    bool hasConnection = await internetCheck.hasConnection();
    if (hasConnection) {
      if (state is PengumumanLoadedState) {
        PengumumanLoadedState pengumumanLoadedState =
            state as PengumumanLoadedState;
        if (pengumumanLoadedState.hasReachedMax) {
          log.i("_getPengumuman hasReachedMax");
        } else {
          int newPage = pengumumanLoadedState.page + 1;
          final result = await getPengungumanWithCategory.execute(
              newPage.toString(), defaultLimit.toString(), kategori4);

          await result.fold(
            (failure) async {
              emit(PengumumanLoadedState(
                  page: newPage - 1,
                  pengumumanList: pengumumanLoadedState.pengumumanList,
                  hasReachedMax: true));
              log.i(
                  "_getPengumuman emit page: ${(newPage - 1)} and hasReachedMax");
            },
            (pengumumanList) async {
              bool hasReachedMax = pengumumanList.data.isEmpty ||
                  pengumumanList.data.length < defaultLimit;
              emit(PengumumanLoadedState(
                  page: newPage,
                  pengumumanList: pengumumanLoadedState.pengumumanList +
                      pengumumanList.data,
                  hasReachedMax: hasReachedMax));
              log.i(
                  "_getPengumuman emit page: $newPage hasReachedMax: $hasReachedMax");
            },
          );
        }
      } else {
        final result = await getPengungumanWithCategory.execute(
            '1', defaultLimit.toString(), kategori4);

        await result.fold(
          (failure) async {
            emit(PengumumanErrorState());
          },
          (pengumumanList) async {
            bool hasReachedMax = pengumumanList.data.isEmpty ||
                pengumumanList.data.length < defaultLimit;
            emit(PengumumanLoadedState(
                page: 1,
                pengumumanList: pengumumanList.data,
                hasReachedMax: hasReachedMax));
          },
        );
      }
    } else {
      if (state is PengumumanLoadedState) {
      } else {
        emit(PengumumanNoInternetState());
      }
    }
  }
}
