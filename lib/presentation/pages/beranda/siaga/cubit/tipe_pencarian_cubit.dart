import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tipe_pencarian_state.dart';

class TipePencarianCubit extends Cubit<TipePencarianState> {
  TipePencarianCubit() : super(TipePencarianPT());

  void changeTipePencarian(String tipe) {
    print("tipE $tipe");
    if (tipe == "Nama Perguruan Tinggi") {
      emit(TipePencarianPT());
    } else {
      emit(TipePencarianTiket());
    }
  }
}
