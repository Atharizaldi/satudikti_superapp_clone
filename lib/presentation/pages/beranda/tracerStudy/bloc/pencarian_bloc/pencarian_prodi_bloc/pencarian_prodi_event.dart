import 'package:equatable/equatable.dart';

abstract class PencarianProdiTracerEvent extends Equatable {
  const PencarianProdiTracerEvent();
}

class GetListProdiTracerEvent extends PencarianProdiTracerEvent {
  final String? kodePT;
  final String? keyword;

  GetListProdiTracerEvent({required this.kodePT, required this.keyword});

  @override
  List<Object> get props => [];
}

