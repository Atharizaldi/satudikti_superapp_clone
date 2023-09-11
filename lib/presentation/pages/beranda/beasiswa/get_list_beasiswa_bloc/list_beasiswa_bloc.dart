import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:app/domain/usecases/beasiswa/getListBeasiswa.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_beasiswa_event.dart';
part 'list_beasiswa_state.dart';

class ListBeasiswaBloc extends Bloc<ListBeasiswaEvent, ListBeasiswaState> {
  GetListBeasiswa getListBeasiswaSedangDibuka;
  GetListBeasiswaSedangDitutup getListBeasiswaSedangDitutup;
  GetListBeasiswaAkanDibuka getListBeasiswaAkanDibuka;
  InternetCheck internetCheck;

  ListBeasiswaBloc(
      {required this.getListBeasiswaSedangDibuka,
      required this.internetCheck,
      required this.getListBeasiswaSedangDitutup,
      required this.getListBeasiswaAkanDibuka})
      : super(ListBeasiswaInitialState()) {
    on<FetchListBeasiswaEvent>(_getBeasiswa);
  }

  void _getBeasiswa(
      FetchListBeasiswaEvent event, Emitter<ListBeasiswaState> emit) async {
    Beasiswa? beasiswaDibuka = Beasiswa(message: '');
    Beasiswa? beasiswaDitutup = Beasiswa(message: '');
    Beasiswa? beasiswaAkanDibuka = Beasiswa(message: '');

    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      emit(ListBeasiswaLoadingState());
      final resultSedangDibuka = await getListBeasiswaSedangDibuka.execute(1);
      final resultSedangDitutup = await getListBeasiswaSedangDitutup.execute(1);
      final resultAkanDibuka = await getListBeasiswaAkanDibuka.execute(1);
      await resultSedangDibuka.fold(
        (failure) async {
          if (failure.message == "internalServer500") {
            emit(ListBeasiswaErrorState());
            beasiswaDibuka = null;
          } else {
            emit(ListBeasiswaNoInternetState());
            beasiswaDibuka = null;
          }
        },
        (listBeasiswaSedangDibuka) async {
          beasiswaDibuka = listBeasiswaSedangDibuka;
        },
      );
      await resultSedangDitutup.fold(
        (failure) async {
          if (failure.message == "internalServer500") {
            emit(ListBeasiswaErrorState());
            beasiswaDitutup = null;
          } else {
            emit(ListBeasiswaNoInternetState());
            beasiswaDitutup = null;
          }
        },
        (listBeasiswaSedangDibuka) async {
          beasiswaDitutup = listBeasiswaSedangDibuka;
        },
      );

      await resultAkanDibuka.fold(
              (failure) async{
                if(failure.message == 'internalServer500'){
                  emit(ListBeasiswaErrorState());
                  beasiswaAkanDibuka = null;
                }else{
                  emit(ListBeasiswaNoInternetState());
                  beasiswaAkanDibuka = null;
                }
              },
              (listBeasiswaAkanDibuka) async{
                beasiswaAkanDibuka = listBeasiswaAkanDibuka;
              }
          );

      if (beasiswaDibuka != null && beasiswaDitutup != null && beasiswaAkanDibuka != null) {
        emit(ListBeasiswaLoadedState(
            beasiswaDibukaRowCount: beasiswaDibuka!.data!,
            beasiswaDitutupRowCount: beasiswaDitutup!.data!,
            beasiswaAkanDibukaRowCount: beasiswaAkanDibuka!.data!,
            beasiswaDibuka: beasiswaDibuka!.data!.listBeasiswa,
            beasiswaDitutup: beasiswaDitutup!.data!.listBeasiswa,
            beasiswaAkanDibuka: beasiswaAkanDibuka!.data!.listBeasiswa));
      }
    } else {
      emit(ListBeasiswaNoInternetState());
    }
  }
}
