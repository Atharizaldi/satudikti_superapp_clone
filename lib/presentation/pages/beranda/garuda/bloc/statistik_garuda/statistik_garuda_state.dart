part of 'statistik_garuda_bloc.dart';

abstract class StatistikGarudaState extends Equatable {
  const StatistikGarudaState();

  @override
  List<Object> get props => [];
}

class StatistikGarudaInitial extends StatistikGarudaState {}

class StatistikGarudaLoading extends StatistikGarudaState {}

class StatistikGarudaLoaded extends StatistikGarudaState {
  final ModelStatistikGaruda modelStatistikGaruda;

  StatistikGarudaLoaded({required this.modelStatistikGaruda});
  @override
  List<Object> get props => [modelStatistikGaruda];
}

class StatistikGarudaFailed extends StatistikGarudaState {}
