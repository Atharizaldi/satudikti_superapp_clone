part of 'list_beasiswa_bloc.dart';

abstract class ListBeasiswaEvent extends Equatable {
  const ListBeasiswaEvent();

  @override
  List<Object> get props => [];
}

class FetchListBeasiswaEvent extends ListBeasiswaEvent {}
