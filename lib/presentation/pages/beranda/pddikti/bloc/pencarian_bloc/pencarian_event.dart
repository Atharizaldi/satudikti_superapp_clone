part of 'pencarian_bloc.dart';

abstract class PencarianEvent extends Equatable {
  const PencarianEvent();

  @override
  List<Object> get props => [];
}

class LoadPencarianEvent extends PencarianEvent {
  final String keyword;
  LoadPencarianEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
