part of 'bts_provinsi_bloc.dart';

abstract class BtsProvinsiEvent extends Equatable {
  const BtsProvinsiEvent();

  @override
  List<Object> get props => [];
}

class BtsSearchProvinsiEvent extends BtsProvinsiEvent {
  final String query;
  final Map<String, String> listAllProvinsi;

  BtsSearchProvinsiEvent({
    required this.query,
    required this.listAllProvinsi,
  });

  @override
  List<Object> get props => [query];
}
