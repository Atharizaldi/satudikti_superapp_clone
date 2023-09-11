part of 'list_tawaran_program_bloc.dart';

abstract class ListTawaranProgramEvent extends Equatable {
  const ListTawaranProgramEvent();

  @override
  List<Object> get props => [];
}

class GetListTawaranProgramEvent extends ListTawaranProgramEvent {}
