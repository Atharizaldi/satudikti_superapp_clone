import 'package:equatable/equatable.dart';

abstract class PencarianPtTracerEvent extends Equatable {
  const PencarianPtTracerEvent();
}

class GetListPtTracerEvent extends PencarianPtTracerEvent {
  final String? keyword;

  GetListPtTracerEvent({required this.keyword});

  @override
  List<Object> get props => [];
}

