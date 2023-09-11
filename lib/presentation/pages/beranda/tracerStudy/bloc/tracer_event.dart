part of 'tracer_bloc.dart';

abstract class TracerEvent extends Equatable {
  const TracerEvent();
}

class TracerConfigEvent extends TracerEvent {
  final int moduleId;

  TracerConfigEvent({
    required this.moduleId,
  });

  @override
  List<Object> get props => [moduleId];
}
