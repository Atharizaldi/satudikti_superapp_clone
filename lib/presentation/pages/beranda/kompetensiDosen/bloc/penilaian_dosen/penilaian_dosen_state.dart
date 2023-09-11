part of 'penilaian_dosen_bloc.dart';

abstract class PenilaianDosenState extends Equatable {
  const PenilaianDosenState();

  @override
  List<Object> get props => [];
}

class PenilaianDosenInitial extends PenilaianDosenState {}

class PenilaianDosenNoInternet extends PenilaianDosenState {}

class PenilaianDosenError extends PenilaianDosenState {}

class PenilaianDosenLoaded extends PenilaianDosenState {
  final PenilaianDosen penilaianDosen;
  PenilaianDosenLoaded({required this.penilaianDosen});
}
