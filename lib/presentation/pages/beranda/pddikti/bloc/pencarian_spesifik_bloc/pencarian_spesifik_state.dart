part of 'pencarian_spesifik_bloc.dart';

abstract class PencarianSpesifikState extends Equatable {
  const PencarianSpesifikState();

  @override
  List<Object> get props => [];
}

class PencarianSpesifikInitialState extends PencarianSpesifikState {}

class PencarianSpesifikNoInternetState extends PencarianSpesifikState {}

class PencarianSpesifikErrorState extends PencarianSpesifikState {}

class PencarianSpesifikLoadedState extends PencarianSpesifikState {}
