part of 'kampusmerdeka_bloc.dart';

abstract class KampusmerdekaState extends Equatable {
  const KampusmerdekaState();

  @override
  List<Object> get props => [];
}

class KampusmerdekaLoadingState extends KampusmerdekaState {}

class KampusmerdekaLoadedState extends KampusmerdekaState {
  final List<MBKMList.Data> running;
  final List<MBKMList.Data> willBeRunning;

  KampusmerdekaLoadedState({
    required this.running,
    required this.willBeRunning,
  });

  @override
  List<Object> get props => [running, willBeRunning];
}

class KampusmerdekaNoInternetState extends KampusmerdekaState {}

class KampusmerdekaErrorState extends KampusmerdekaState {}
