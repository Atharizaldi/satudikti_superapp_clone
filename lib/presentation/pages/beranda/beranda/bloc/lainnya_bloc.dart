import 'dart:async';

import 'package:app/data/source/local/model/menuItems.dart';
import 'package:app/presentation/component/menuItemsList.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'lainnya_event.dart';
part 'lainnya_state.dart';

List<MenuItems> replaceList(List<MenuItems> list, List<MenuItems> targetList) {
  targetList.clear();
  for (MenuItems menu in list) {
    targetList.add(menu);
  }
  return targetList;
}

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class LainnyaBloc extends Bloc<LainnyaEvent, LainnyaState> {
  Logger log;
  LainnyaBloc({required this.log}) : super(LainnyaInitial()) {
    on<LainnyaEditEvent>(_lainnyaEditEvent);
    on<LainnyaSaveEvent>(_lainnyaSaveEvent);
  }

  FutureOr<void> _lainnyaEditEvent(
      LainnyaEditEvent event, Emitter<LainnyaState> emit) {
    print("EDITT BLOC");
    emit(LainnyaEditingState());
  }

  FutureOr<void> _lainnyaSaveEvent(
      LainnyaSaveEvent event, Emitter<LainnyaState> emit) async {
    SharedPreferences prefs = await _prefs;

    replaceList(event.listMenuFavorit, menuItemsListFavorit);
    replaceList(event.listMenuLainnya, menuItemsListLainnya);

    prefs.setString('listMenuFavorit', MenuItems.encode(event.listMenuFavorit));
    prefs.setString('listMenuLainnya', MenuItems.encode(event.listMenuLainnya));

    emit(LainnyaSavingState(
        listMenuFavorit: event.listMenuFavorit,
        listMenuLainnya: event.listMenuLainnya));
  }
}
