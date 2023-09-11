part of 'ijazahbyno_bloc.dart';

abstract class IjazahbynoState extends Equatable {
  const IjazahbynoState();

  @override
  List<Object> get props => [];
}

class IjazahbynoLoading extends IjazahbynoState {}

class IjazahbynoLoaded extends IjazahbynoState {
  final StatusByNoReg listByReg;

  IjazahbynoLoaded({required this.listByReg});
  @override
  List<Object> get props => [];
}

class IjazahbynoFailed extends IjazahbynoState {
  @override
  List<Object> get props => [];
}
