part of 'list_tawaran_program_bloc.dart';

abstract class ListTawaranProgramState extends Equatable {
  const ListTawaranProgramState();

  @override
  List<Object> get props => [];
}

class ListTawaranProgramInitial extends ListTawaranProgramState {}

class ListTawaranProgramError extends ListTawaranProgramState {}

class ListTawaranProgramNoInternet extends ListTawaranProgramState {}

class ListTawaranProgramLoaded extends ListTawaranProgramState {
  final List<TawaranProgram> list;

  ListTawaranProgramLoaded({required this.list});
}
