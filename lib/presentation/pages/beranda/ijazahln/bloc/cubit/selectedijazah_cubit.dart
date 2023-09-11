import 'package:bloc/bloc.dart';

class SelectedijazahCubit extends Cubit<bool> {
  SelectedijazahCubit() : super(false);
  void isIjazahSelected() {
    emit(true);
  }
}
