part of 'garuda_umum_search_bloc.dart';

abstract class GarudaUmumSearchEvent extends Equatable {
  const GarudaUmumSearchEvent();

  @override
  List<Object> get props => [];
}

class GarudaUmumSearchMainEvent extends GarudaUmumSearchEvent {
  final String? keyword;
  GarudaUmumSearchMainEvent({this.keyword});
  @override
  List<Object> get props => [keyword.toString()];
}
