part of 'pencarian_bloc.dart';

abstract class PencarianState extends Equatable {
  const PencarianState();

  @override
  List<Object> get props => [];
}

class PencarianInitialState extends PencarianState {}

class PencarianLoadingState extends PencarianState {}

class PencarianNotFoundState extends PencarianState{}

class PencarianNoInternetState extends PencarianState {}

class PencarianLoadedState extends PencarianState {
  final List<Pt> pt;
  final List<Prodi> prodi;
  final List<Dosen> dosen;
  final List<Mahasiswa> mahasiswa;

  PencarianLoadedState({required this.pt, required this.prodi, required this.dosen, required this.mahasiswa});

  @override
  List<Object> get props => [pt, prodi, dosen, mahasiswa];
}
