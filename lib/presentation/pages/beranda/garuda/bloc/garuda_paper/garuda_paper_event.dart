part of 'garuda_paper_bloc.dart';

abstract class GarudaPaperEvent extends Equatable {
  const GarudaPaperEvent();

  @override
  List<Object> get props => [];
}

class GarudaPaperSearchEvent extends GarudaPaperEvent {
  final String? keyword;

  GarudaPaperSearchEvent({this.keyword});
  @override
  List<Object> get props => [keyword.toString()];
}
