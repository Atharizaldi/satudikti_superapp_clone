import 'package:equatable/equatable.dart';

abstract class StatistikTracerEvent extends Equatable {
  const StatistikTracerEvent();
}

class GetStatistikTracerEvent extends StatistikTracerEvent {
  final String? kodePt;

  GetStatistikTracerEvent(this.kodePt);

  @override
  List<Object> get props => [];
}
