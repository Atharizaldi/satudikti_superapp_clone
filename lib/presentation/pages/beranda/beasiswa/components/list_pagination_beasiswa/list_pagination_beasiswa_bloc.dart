import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:app/domain/usecases/beasiswa/getListBeasiswa.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_pagination_beasiswa_event.dart';
part 'list_pagination_beasiswa_state.dart';

class ListPaginationBeasiswaBloc
    extends Bloc<ListPaginationBeasiswaEvent, ListPaginationBeasiswaState> {
  InternetCheck internetCheck;
  GetListBeasiswa getListBeasiswaSedangDibuka;
  GetListBeasiswaSedangDitutup getListBeasiswaSedangDitutup;
  GetListBeasiswaAkanDibuka getListBeasiswaAkanDibuka;

  ListPaginationBeasiswaBloc(
      {required this.internetCheck,
      required this.getListBeasiswaSedangDibuka,
      required this.getListBeasiswaSedangDitutup,
      required this.getListBeasiswaAkanDibuka})
      : super(ListPaginationBeasiswaInitial()) {
    on<ListPaginationBeasiswaDibukaEvent>(_sedangDibuka);
    on<ListPaginationBeasiswaDitutupEvent>(_sedangDitutup);
    on<ListPaginationBeasiswaAkanDibukaEvent>(_akanDibuka);
  }
  void _sedangDibuka(ListPaginationBeasiswaDibukaEvent event,
      Emitter<ListPaginationBeasiswaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is ListPaginationBeasiswaLoaded) {
        ListPaginationBeasiswaLoaded listPaginationBeasiswaLoaded =
            state as ListPaginationBeasiswaLoaded;
        if (listPaginationBeasiswaLoaded.hasReachedMax) {
        } else {
          int newPage = listPaginationBeasiswaLoaded.newPage + 1;
          final result = await getListBeasiswaSedangDibuka.execute(newPage);
          await result.fold((l) async {
            emit(ListPaginationBeasiswaFailed());
          }, (r) async {
            bool hasReached = r.data!.listBeasiswa.isEmpty ||
                r.data!.listBeasiswa.length < defaultLimit;
            emit(ListPaginationBeasiswaLoaded(
                hasReachedMax: hasReached,
                newPage: newPage,
                beasiswa: r,
                listBeasiswa: listPaginationBeasiswaLoaded.listBeasiswa +
                    r.data!.listBeasiswa));
          });
        }
      } else {
        emit(ListPaginationBeasiswaLoading());
        final result = await getListBeasiswaSedangDibuka.execute(1);
        await result.fold((l) async {
          emit(ListPaginationBeasiswaFailed());
        }, (r) async {
          bool hasReached = r.data!.listBeasiswa.isEmpty ||
              r.data!.listBeasiswa.length < defaultLimit;
          emit(ListPaginationBeasiswaLoaded(
              hasReachedMax: hasReached,
              newPage: 1,
              beasiswa: r,
              listBeasiswa: r.data!.listBeasiswa));
        });
      }
    } else {
      emit(ListPaginationBeasiswaNoInternet());
    }
  }

  void _akanDibuka(ListPaginationBeasiswaAkanDibukaEvent event,
      Emitter<ListPaginationBeasiswaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is ListPaginationBeasiswaLoaded) {
        ListPaginationBeasiswaLoaded listPaginationBeasiswaLoaded =
        state as ListPaginationBeasiswaLoaded;
        if (listPaginationBeasiswaLoaded.hasReachedMax) {
        } else {
          int newPage = listPaginationBeasiswaLoaded.newPage + 1;
          final result = await getListBeasiswaAkanDibuka.execute(newPage);
          await result.fold((l) async {
            emit(ListPaginationBeasiswaFailed());
          }, (r) async {
            bool hasReached = r.data!.listBeasiswa.isEmpty ||
                r.data!.listBeasiswa.length < defaultLimit;
            emit(ListPaginationBeasiswaLoaded(
                hasReachedMax: hasReached,
                newPage: newPage,
                beasiswa: r,
                listBeasiswa: listPaginationBeasiswaLoaded.listBeasiswa +
                    r.data!.listBeasiswa));
          });
        }
      } else {
        emit(ListPaginationBeasiswaLoading());
        final result = await getListBeasiswaAkanDibuka.execute(1);
        await result.fold((l) async {
          emit(ListPaginationBeasiswaFailed());
        }, (r) async {
          bool hasReached = r.data!.listBeasiswa.isEmpty ||
              r.data!.listBeasiswa.length < defaultLimit;
          emit(ListPaginationBeasiswaLoaded(
              hasReachedMax: hasReached,
              newPage: 1,
              beasiswa: r,
              listBeasiswa: r.data!.listBeasiswa));
        });
      }
    } else {
      emit(ListPaginationBeasiswaNoInternet());
    }
  }

  void _sedangDitutup(ListPaginationBeasiswaDitutupEvent event,
      Emitter<ListPaginationBeasiswaState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      if (state is ListPaginationBeasiswaLoaded) {
        ListPaginationBeasiswaLoaded listPaginationBeasiswaLoaded =
            state as ListPaginationBeasiswaLoaded;
        if (listPaginationBeasiswaLoaded.hasReachedMax) {
        } else {
          int newPage = listPaginationBeasiswaLoaded.newPage + 1;
          final result = await getListBeasiswaSedangDitutup.execute(newPage);
          await result.fold((l) async {
            emit(ListPaginationBeasiswaFailed());
          }, (r) async {
            bool hasReached = r.data!.listBeasiswa.isEmpty ||
                r.data!.listBeasiswa.length < defaultLimit;
            emit(ListPaginationBeasiswaLoaded(
                hasReachedMax: hasReached,
                newPage: newPage,
                beasiswa: r,
                listBeasiswa: listPaginationBeasiswaLoaded.listBeasiswa +
                    r.data!.listBeasiswa));
          });
        }
      } else {
        emit(ListPaginationBeasiswaLoading());
        final result = await getListBeasiswaSedangDitutup.execute(1);
        await result.fold((l) async {
          emit(ListPaginationBeasiswaFailed());
        }, (r) async {
          bool hasReached = r.data!.listBeasiswa.isEmpty ||
              r.data!.listBeasiswa.length < defaultLimit;
          emit(ListPaginationBeasiswaLoaded(
              hasReachedMax: hasReached,
              newPage: 1,
              beasiswa: r,
              listBeasiswa: r.data!.listBeasiswa));
        });
      }
    } else {
      emit(ListPaginationBeasiswaNoInternet());
    }
  }
}
