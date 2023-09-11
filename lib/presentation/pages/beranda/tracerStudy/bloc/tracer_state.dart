part of 'tracer_bloc.dart';

abstract class TracerState extends Equatable {
  const TracerState();
}

class TracerConfigInitial extends TracerState {
  @override
  List<Object> get props => [];
}

class TracerConfigLoadedState extends TracerState {
  final Config config;
  TracerConfigLoadedState({required this.config});
  @override
  List<Object> get props => [config];
}

class TracerConfigLoadingState extends TracerState {
  @override
  List<Object> get props => [];
}

class TracerConfigErrorState extends TracerState {
  @override
  List<Object> get props => [];
}
