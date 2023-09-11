part of 'penempatan_sister_bloc.dart';

abstract class PenempatanSisterState extends Equatable {
  const PenempatanSisterState();

  @override
  List<Object> get props => [];
}

class PenempatanSisterinInitial extends PenempatanSisterState {}

class PenempatanSisterLoadedState extends PenempatanSisterState {
  final PenempatanSister penempatanSister;
  final String nidn;

  PenempatanSisterLoadedState(
      {required this.penempatanSister, required this.nidn});

  @override
  List<Object> get props => [penempatanSister];
}

class PenempatanSisterNoInternetState extends PenempatanSisterState {
  final String nidn;

  PenempatanSisterNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class PenempatanSisterErrorState extends PenempatanSisterState {
  final String nidn;

  PenempatanSisterErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class PenempatanSisterNotFoundState extends PenempatanSisterState {
  final PenempatanSister? penempatanSister;
  PenempatanSisterNotFoundState(this.penempatanSister);

  @override
  List<Object> get props => [];
}
