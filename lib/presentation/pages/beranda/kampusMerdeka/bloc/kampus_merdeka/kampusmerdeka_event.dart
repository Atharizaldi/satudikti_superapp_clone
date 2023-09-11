part of 'kampusmerdeka_bloc.dart';

abstract class KampusmerdekaEvent extends Equatable {
  const KampusmerdekaEvent();

  @override
  List<Object> get props => [];
}

class GetKMListEvent extends KampusmerdekaEvent {}

