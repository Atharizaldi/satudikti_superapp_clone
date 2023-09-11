part of 'lainnya_bloc.dart';

abstract class LainnyaState extends Equatable {
  @override
  List<Object> get props => [];
}

class LainnyaInitial extends LainnyaState {}

class LainnyaEditingState extends LainnyaState {}

class LainnyaSavingState extends LainnyaState {
  final List<MenuItems> listMenuFavorit;
  final List<MenuItems> listMenuLainnya;
  LainnyaSavingState(
      {required this.listMenuFavorit, required this.listMenuLainnya});
}
