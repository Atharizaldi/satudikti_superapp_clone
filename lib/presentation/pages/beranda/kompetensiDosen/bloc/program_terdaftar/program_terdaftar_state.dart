part of 'program_terdaftar_bloc.dart';

abstract class ProgramTerdaftarState extends Equatable {
  const ProgramTerdaftarState();

  @override
  List<Object> get props => [];
}

class ProgramTerdaftarInitial extends ProgramTerdaftarState {}

class ProgramTerdaftarLoaded extends ProgramTerdaftarState {
  final List<ProgramTerdaftar> list;
  ProgramTerdaftarLoaded({required this.list});
}

class ProgramTerdaftarError extends ProgramTerdaftarState {}

class ProgramTerdaftarNoInternet extends ProgramTerdaftarState {}
