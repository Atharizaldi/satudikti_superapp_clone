part of 'lainnya_bloc.dart';

abstract class LainnyaEvent extends Equatable {
  const LainnyaEvent();

  @override
  List<Object> get props => [];
}

class LainnyaEditEvent extends LainnyaEvent {}

class LainnyaSaveEvent extends LainnyaEvent {
  final List<MenuItems> listMenuFavorit;
  final List<MenuItems> listMenuLainnya;

  LainnyaSaveEvent(
      {required this.listMenuFavorit, required this.listMenuLainnya});
}
