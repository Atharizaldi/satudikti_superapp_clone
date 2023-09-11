import 'package:equatable/equatable.dart';

abstract class PencarianKabupatenTracerEvent extends Equatable {
  const PencarianKabupatenTracerEvent();
}

class GetListKabupatenTracerEvent extends PencarianKabupatenTracerEvent {
  final String? kodeProv;

  GetListKabupatenTracerEvent(this.kodeProv);

  @override
  List<Object> get props => [];
}

