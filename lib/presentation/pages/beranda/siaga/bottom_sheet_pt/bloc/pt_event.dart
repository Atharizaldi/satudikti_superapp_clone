part of 'pt_bloc.dart';

abstract class PtEvent extends Equatable {
  const PtEvent();
}

class SearchPtEvent extends PtEvent {
  final String query;

  SearchPtEvent({required this.query});

  @override
  List<Object> get props => [query];
}
