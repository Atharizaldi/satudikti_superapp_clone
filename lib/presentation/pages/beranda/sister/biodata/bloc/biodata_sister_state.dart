part of 'biodata_sister_bloc.dart';

abstract class BiodataSisterState extends Equatable {
  const BiodataSisterState();

  @override
  List<Object> get props => [];
}

class BiodataSisterInitial extends BiodataSisterState {}

class BiodataSisterLoadedState extends BiodataSisterState {
  final BiodataSister biodataSister;
  final String nidn;

  BiodataSisterLoadedState({required this.biodataSister, required this.nidn});

  @override
  List<Object> get props => [biodataSister];
}

class BiodataSisterNoInternetState extends BiodataSisterState {
  final String nidn;

  BiodataSisterNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class BiodataSisterErrorState extends BiodataSisterState {
  final String nidn;

  BiodataSisterErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class BiodataSisterNotFoundState extends BiodataSisterState {
  final BiodataSister? biodataSister;
  BiodataSisterNotFoundState(this.biodataSister);

  @override
  List<Object> get props => [];
}
