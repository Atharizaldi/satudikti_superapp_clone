part of 'pendidikan_formal_sister_bloc.dart';

abstract class PendidikanSisterState extends Equatable {
  const PendidikanSisterState();

  @override
  List<Object> get props => [];
}

class PendidikanSisterinInitial extends PendidikanSisterState {}

class PendidikanSisterinLoading extends PendidikanSisterState {
  @override
  List<Object> get props => [];
}

class PendidikanSisterLoadedState extends PendidikanSisterState {
  final List<PendidikanFormalDosen> pendidikanFormalDosenSister;
  final List<PendidikanDiklat> pendidikanDiklatSister;
  final List<PendidikanPengajaran> pendidikanPengajaran;
  final List<PendidikanPembimbingan> pendidikanPembimbingan;
  final List<PendidikanPengujian> pendidikanPengujian;
  final String nidn;

  PendidikanSisterLoadedState(
      {required this.nidn,
      required this.pendidikanPembimbingan,
      required this.pendidikanPengujian,
      required this.pendidikanFormalDosenSister,
      required this.pendidikanDiklatSister,
      required this.pendidikanPengajaran});

  @override
  List<Object> get props => [pendidikanDiklatSister];
}

class PendidikanNoInternetState extends PendidikanSisterState {
  final String nidn;

  PendidikanNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class PendidikanSisterErrorState extends PendidikanSisterState {
  final String nidn;

  PendidikanSisterErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class PendidikanSisterNotFoundState extends PendidikanSisterState {
  final String nidn;

  PendidikanSisterNotFoundState({required this.nidn});

  @override
  List<Object> get props => [];
}
