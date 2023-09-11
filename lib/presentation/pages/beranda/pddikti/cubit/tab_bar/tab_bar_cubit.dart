import 'package:bloc/bloc.dart';

class TabBarCubit extends Cubit<int> {
  TabBarCubit() : super(0);

  void changeTabIndex(int index) {
    print("CHANGE INDEX $index");
    emit(index);
  }

  int moveLeftTab() {
    int currentIndex = this.state;
    print("currin $currentIndex");
    if (currentIndex > 0) {
      print("moveleft");
      emit(currentIndex - 1);
      return currentIndex - 1;
    }
    return 0;
  }

  int moveRightTab(int totalItem) {
    int currentIndex = this.state;
    if (currentIndex < totalItem - 1) {
      emit(currentIndex + 1);
      return currentIndex + 1;
    }
    return totalItem - 1;
  }
}
