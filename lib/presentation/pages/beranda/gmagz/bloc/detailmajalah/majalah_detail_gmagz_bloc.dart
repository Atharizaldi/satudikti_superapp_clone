import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_detail_gmagz.dart';
import 'package:app/domain/usecases/gmagz/get_majalah_detail_gmagz.dart';
import 'package:app/domain/usecases/gmagz/put_downloader_gmagz.dart';
import 'package:app/domain/usecases/gmagz/put_reader_gmagz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'majalah_detail_gmagz_event.dart';
part 'majalah_detail_gmagz_state.dart';

class MajalahDetailGMagzBloc
    extends Bloc<MajalahDetailGMagzevent, MajalahDetailGMagzState> {
  GetMajalahDetailGMagz getMajalahDetailGMagz;
  PutDownloaderGMAgz putDownloaderGMAgz;
  PutReaderGMagz putReaderGMagz;

  Logger log;
  InternetCheck internetCheck;
  String id = '';

  MajalahDetailGMagzBloc({
    required this.getMajalahDetailGMagz,
    required this.putDownloaderGMAgz,
    required this.putReaderGMagz,
    required this.internetCheck,
    required this.log,
  }) : super(MajalahDetailGMagzinInitial()) {
    on<GetMajalahDetailGMagzEvent>(_getMajalahDetail);
    on<PutGMagzDownloader>(_putDownloader);
    on<PutGMagzReader>(_putReader);
  }

  void _putReader(
      PutGMagzReader event, Emitter<MajalahDetailGMagzState> emit) async {
    await putReaderGMagz.execute(event.id);
  }

  void _putDownloader(
      PutGMagzDownloader event, Emitter<MajalahDetailGMagzState> emit) async {
    await putDownloaderGMAgz.execute(event.id);
  }

  void _getMajalahDetail(GetMajalahDetailGMagzEvent event,
      Emitter<MajalahDetailGMagzState> emit) async {
    print("================KEBLOC============");
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      emit(MajalahDetailLoading());
      id = event.id;
      final result = await getMajalahDetailGMagz.execute(event.id);

      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(MajalahDetailGMagzErrorState(id: event.id));
          } else if (failure.message == 'error404') {
            emit(MajalahDetailGMagzNotFoundState(null));
          } else if (failure.message == '') {
            emit(MajalahDetailGMagzErrorState(id: event.id));
          }
        },
        (majalahDetailGMagz) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          emit(MajalahDetailGMagzLoadedState(
              review: majalahDetailGMagz.dataMajalah.review,
              dataMajalah: majalahDetailGMagz.dataMajalah));
        },
      );
    } else {
      emit(MajalahDetailGMagzNoInternetState(id: event.id));
    }
  }
}
