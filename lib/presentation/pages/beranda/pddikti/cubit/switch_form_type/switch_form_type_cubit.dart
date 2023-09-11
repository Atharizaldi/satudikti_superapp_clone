import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_form_type_state.dart';

class SwitchFormTypeCubit extends Cubit<SwitchFormTypeState> {
  SwitchFormTypeCubit() : super(SwitchFormTypeDosen());

  void changeType(String kategori) {
    print("KATEGORI $kategori");
    if (kategori == "Data Mahasiswa") {
      emit(SwitchFormTypeMahasiswa());
    } else if (kategori == "Data Dosen") {
      emit(SwitchFormTypeDosen());
    } else if (kategori == "Data Perguruan Tinggi") {
      emit(SwitchFormTypePT());
    } else if (kategori == "Data Prodi") {
      emit(SwitchFormTypeProdi());
    }
  }
}
