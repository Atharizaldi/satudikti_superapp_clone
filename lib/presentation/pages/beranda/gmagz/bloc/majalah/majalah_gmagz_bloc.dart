import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_gmagz.dart';
import 'package:app/domain/usecases/gmagz/get_majalah_gmagz.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'majalah_gmagz_event.dart';
part 'majalah_gmagz_state.dart';

class MajalahGMagzBloc extends Bloc<MajalahGMagzevent, MajalahGMagzState> {
  GetMajalahGMagz getMajalahGMagz;

  Logger log;
  InternetCheck internetCheck;

  String keywordSearch = "";
  String displayBySearch = "";

  MajalahGMagzBloc({
    required this.getMajalahGMagz,
    required this.internetCheck,
    required this.log,
  }) : super(MajalahGMagzinInitial()) {
    on<GetMajalahGMagzEvent>(_getMajalah);
  }

  void _getMajalah(
      GetMajalahGMagzEvent event, Emitter<MajalahGMagzState> emit) async {
    print("================KEBLOC============");
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      if (state is MajalahGMagzLoadedState) {
        MajalahGMagzLoadedState majalahGMagzLoadedState =
            state as MajalahGMagzLoadedState;

        if (event.judul != keywordSearch ||
            majalahGMagzLoadedState.displayBy != event.displayby) {
          keywordSearch = event.judul;
          displayBySearch = event.displayby;
          emit(MajalahGMagzLoading());
          final result = await getMajalahGMagz.execute(event.sort,
              Uri.encodeComponent(keywordSearch), event.displayby, 1);

          await result.fold(
            (failure) async {
              log.d('LoggedInBloc - error di majalah bloc: $state');
              log.d('LoggedInBloc - failure msg: ${failure.message}');
              if (failure.message == 'error500') {
                emit(MajalahGMagzErrorState(sort: event.sort));
              } else if (failure.message == 'error404') {
                emit(MajalahGMagzNotFoundState(null));
              } else if (failure.message == '') {
                emit(MajalahGMagzErrorState(sort: event.sort));
              }
            },
            (majalahGMagz) async {
              emit(MajalahGMagzLoadedState(
                  displayBy: event.displayby,
                  totalRowCount: majalahGMagz.data.totalRowCount,
                  hasReachedMax: majalahGMagz.data.listBook.isEmpty ||
                      majalahGMagz.data.listBook.length < defaultLimit ||
                      majalahGMagzLoadedState.listBook.length + 10 ==
                          majalahGMagz.data.totalRowCount,
                  newPage: 1,
                  listBook: majalahGMagz.data.listBook,
                  sort: event.sort,
                  judul: event.judul));
            },
          );
        } else if (majalahGMagzLoadedState.hasReachedMax &&
            event.judul == keywordSearch) {
        } else if (majalahGMagzLoadedState.hasReachedMax == false &&
            majalahGMagzLoadedState.judul == keywordSearch) {
          int newPage = majalahGMagzLoadedState.newPage + 1;

          final result = await getMajalahGMagz.execute(
              event.sort,
              Uri.encodeComponent(majalahGMagzLoadedState.judul),
              event.displayby,
              newPage);

          await result.fold(
            (failure) async {
              log.d('LoggedInBloc - error di majalah bloc: $state');
              log.d('LoggedInBloc - failure msg: ${failure.message}');
              if (failure.message == 'error500') {
                emit(MajalahGMagzErrorState(sort: event.sort));
              } else if (failure.message == 'error404') {
                emit(MajalahGMagzNotFoundState(null));
              } else if (failure.message == '') {
                emit(MajalahGMagzErrorState(sort: event.sort));
              }
            },
            (majalahGMagz) async {
              log.d('LoggedInBloc - masuk ke majalah: $state');

              emit(MajalahGMagzLoadedState(
                  displayBy: event.displayby,
                  totalRowCount: majalahGMagz.data.totalRowCount,
                  hasReachedMax: majalahGMagz.data.listBook.isEmpty ||
                      majalahGMagz.data.listBook.length < defaultLimit ||
                      majalahGMagzLoadedState.listBook.length + 10 ==
                          majalahGMagz.data.totalRowCount,
                  newPage: newPage,
                  listBook: majalahGMagzLoadedState.listBook +
                      majalahGMagz.data.listBook,
                  sort: majalahGMagzLoadedState.sort,
                  judul: event.judul));
            },
          );
        }
      } else {
        emit(MajalahGMagzLoading());
        keywordSearch = event.judul;

        final result = await getMajalahGMagz.execute(
            event.sort, Uri.encodeComponent(event.judul), event.displayby, 1);

        await result.fold(
          (failure) async {
            log.d('LoggedInBloc - error di majalah bloc: $state');
            log.d('LoggedInBloc - failure msg: ${failure.message}');
            if (failure.message == 'error500') {
              emit(MajalahGMagzErrorState(sort: event.sort));
            } else if (failure.message == 'error404') {
              emit(MajalahGMagzNotFoundState(null));
            } else if (failure.message == '') {
              emit(MajalahGMagzErrorState(sort: event.sort));
            }
          },
          (majalahGMagz) async {
            log.d('LoggedInBloc - masuk ke Majalah: $state');

            emit(MajalahGMagzLoadedState(
                displayBy: event.displayby,
                totalRowCount: majalahGMagz.data.totalRowCount,
                hasReachedMax: majalahGMagz.data.listBook.isEmpty ||
                    majalahGMagz.data.listBook.length < defaultLimit,
                newPage: 1,
                listBook: majalahGMagz.data.listBook,
                sort: event.sort,
                judul: event.judul));
          },
        );
      }
    } else {
      emit(MajalahGMagzNoInternetState(sort: event.sort));
    }
  }
}
