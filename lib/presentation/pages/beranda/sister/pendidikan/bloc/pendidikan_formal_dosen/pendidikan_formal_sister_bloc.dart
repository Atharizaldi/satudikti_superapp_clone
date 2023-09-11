import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_diklat_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_formal_dosen_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pembimbingan_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengajaran_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengujian_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_diklat_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_formal_dosen_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_pembimbingan_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_pengajaran_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_pengujian_sister.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'pendidikan_formal_sister_event.dart';
part 'pendidikan_formal_sister_state.dart';

class PendidikanSisterBloc
    extends Bloc<PendidikanSisterEvent, PendidikanSisterState> {
  GetPendidikanFormalDosenSister getPendidikanFormalDosenSister;
  GetPendidikanDiklatSister getPendidikanDiklatSister;
  GetPendidikanPengajaranSister getPendidikanPengajaranSister;
  GetPendidikanPembimbinganSister getPendidikanPembimbinganSister;
  GetPendidikanPengujianSister getPendidikanPengujianSister;
  Logger log;
  InternetCheck internetCheck;
  String nidn = "";
  PendidikanSisterBloc({
    required this.getPendidikanPengujianSister,
    required this.getPendidikanPembimbinganSister,
    required this.getPendidikanPengajaranSister,
    required this.getPendidikanFormalDosenSister,
    required this.getPendidikanDiklatSister,
    required this.internetCheck,
    required this.log,
  }) : super(PendidikanSisterinInitial()) {
    on<GetPendidikanSisterEvent>(_getPendidikanFormalDosenSister);
  }

  void _getPendidikanFormalDosenSister(GetPendidikanSisterEvent event,
      Emitter<PendidikanSisterState> emit) async {
    // List<PendidikanINSister.PendidikanFormal> pendidikanINFormal = [];
    print("================KEBLOC============");
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      emit(PendidikanSisterinLoading());
      nidn = event.nidn;
      final result = await getPendidikanFormalDosenSister.execute(event.nidn);
      final result1 = await getPendidikanDiklatSister.execute(
          event.nidn, event.displayByDiklat, event.judulDIklat);

      final result2 = await getPendidikanPengajaranSister.execute(
          event.nidn,
          event.matkulPengajaran.toString(),
          event.displayByPengajaran.toString());

      final result3 = await getPendidikanPembimbinganSister.execute(
          event.nidn, event.displayByPembimbingan, event.judulPembimbingan);

      final result4 = await getPendidikanPengujianSister.execute(
          event.nidn, event.displayByPengujian, event.judulPengujian);

      List<PendidikanFormalDosen> pendidikanFormalDosen = [];
      List<PendidikanDiklat> pendidikanDiklatSister = [];
      List<PendidikanPengajaran> pendidikanPengajaran = [];
      List<PendidikanPembimbingan> pendidikanPembimbingan = [];
      List<PendidikanPengujian> pendidikanPengujian = [];
      await result.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(PendidikanSisterNotFoundState(nidn: event.nidn));
          } else if (failure.message == '') {
            emit(PendidikanNoInternetState(nidn: event.nidn));
          }
        },
        (pendidikanSister) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          pendidikanFormalDosen =
              pendidikanSister.pendidikanFormalDosen.toList();
        },
      );
      await result1.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(PendidikanSisterNotFoundState(nidn: event.nidn));
          } else if (failure.message == '') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          }
        },
        (pendidikanSister) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          pendidikanDiklatSister = pendidikanSister.pendidikanDiklat.toList();
        },
      );
      await result2.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(PendidikanSisterNotFoundState(nidn: event.nidn));
          } else if (failure.message == '') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          }
        },
        (pendidikanSister) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          pendidikanPengajaran = pendidikanSister.pendidikanPengajaran.toList();
        },
      );
      await result3.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(PendidikanSisterNotFoundState(nidn: event.nidn));
          } else if (failure.message == '') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          }
        },
        (pendidikanSister) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          pendidikanPembimbingan =
              pendidikanSister.pendidikanPembimbingan.toList();
        },
      );
      await result4.fold(
        (failure) async {
          log.d('LoggedInBloc - error di profile: $state');
          log.d('LoggedInBloc - failure msg: ${failure.message}');
          if (failure.message == 'error500') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          } else if (failure.message == 'error404') {
            emit(PendidikanSisterNotFoundState(nidn: event.nidn));
          } else if (failure.message == '') {
            emit(PendidikanSisterErrorState(nidn: event.nidn));
          }
        },
        (pendidikanSister) async {
          log.d('LoggedInBloc - masuk ke profil: $state');
          pendidikanPengujian = pendidikanSister.pendidikanPengujian.toList();
        },
      );

      emit(PendidikanSisterLoadedState(
        nidn: nidn,
        pendidikanPengujian: pendidikanPengujian,
        pendidikanPembimbingan: pendidikanPembimbingan,
        pendidikanFormalDosenSister: pendidikanFormalDosen,
        pendidikanDiklatSister: pendidikanDiklatSister,
        pendidikanPengajaran: pendidikanPengajaran,
      ));
    } else {
      emit(PendidikanNoInternetState(nidn: event.nidn));
    }
  }
}
