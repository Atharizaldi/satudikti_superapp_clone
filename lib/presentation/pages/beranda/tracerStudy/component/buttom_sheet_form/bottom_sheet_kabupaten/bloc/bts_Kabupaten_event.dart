part of 'bts_Kabupaten_bloc.dart';

abstract class BtsKabupatenEvent extends Equatable {
  const BtsKabupatenEvent();

  @override
  List<Object> get props => [];
}

class BtsSearchKabupatenEvent extends BtsKabupatenEvent {
  final String query;
  final Map<String, String> listAllKabupaten;

  BtsSearchKabupatenEvent({
    required this.query,
    required this.listAllKabupaten,
  });

  @override
  List<Object> get props => [query];
}
