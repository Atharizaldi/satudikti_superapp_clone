part of 'usulan_dosen_bloc.dart';

abstract class UsulanDosenState extends Equatable {
  const UsulanDosenState();

  @override
  List<Object> get props => [];
}

class UsulanDosenInitial extends UsulanDosenState {}

class UsulanDosenError extends UsulanDosenState {}

class UsulanDosenNoInternet extends UsulanDosenState {}

class UsulanDosenNotFound extends UsulanDosenState {}

class UsulanDosenLoaded extends UsulanDosenState {
  final List<UsulanDosen> listSemua;
  final List<UsulanDosen> listDraft;
  final List<UsulanDosen> listDisetujui;
  final List<UsulanDosen> listDiusulkan;
  final List<UsulanDosen> listDitolak;
  final List<UsulanDosen> listDitangguhkan;

  UsulanDosenLoaded({
    required this.listSemua,
    required this.listDraft,
    required this.listDisetujui,
    required this.listDiusulkan,
    required this.listDitolak,
    required this.listDitangguhkan,
  });
}
