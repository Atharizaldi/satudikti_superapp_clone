part of 'program_terdaftar_bloc.dart';

abstract class ProgramTerdaftarEvent extends Equatable {
  const ProgramTerdaftarEvent();

  @override
  List<Object> get props => [];
}

class GetProgramTerdaftarEvent extends ProgramTerdaftarEvent {
  final String nidn;
  final String tahun;

  GetProgramTerdaftarEvent({required this.nidn, required this.tahun});
}
