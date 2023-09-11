import 'package:bloc/bloc.dart';

class ButtonCariCubit extends Cubit<bool> {
  ButtonCariCubit() : super(false);
  void onType(String namaText, String dateText, String idPTText) {
    emit(namaText.isNotEmpty && dateText.isNotEmpty && idPTText.isNotEmpty);
  }
}
