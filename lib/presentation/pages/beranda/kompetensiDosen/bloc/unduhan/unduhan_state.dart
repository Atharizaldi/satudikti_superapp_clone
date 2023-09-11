part of 'unduhan_bloc.dart';

abstract class UnduhanState extends Equatable {
  const UnduhanState();

  @override
  List<Object> get props => [];
}

class UnduhanInitial extends UnduhanState {}

class UnduhanError extends UnduhanState {}

class UnduhanLoaded extends UnduhanState {
  final Unduhan unduhan;

  UnduhanLoaded({required this.unduhan});
}
