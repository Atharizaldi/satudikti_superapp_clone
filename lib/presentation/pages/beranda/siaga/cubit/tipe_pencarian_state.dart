part of 'tipe_pencarian_cubit.dart';

abstract class TipePencarianState extends Equatable {
  const TipePencarianState();

  @override
  List<Object> get props => [];
}

class TipePencarianInitial extends TipePencarianState {}

class TipePencarianPT extends TipePencarianState {}

class TipePencarianTiket extends TipePencarianState {}
