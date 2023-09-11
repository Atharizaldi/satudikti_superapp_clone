part of 'pencarian_spesifik_bloc.dart';

abstract class PencarianSpesifikEvent extends Equatable {
  const PencarianSpesifikEvent();

  @override
  List<Object> get props => [];
}

class InitPencarianSpesifikEvent extends PencarianSpesifikEvent {}
