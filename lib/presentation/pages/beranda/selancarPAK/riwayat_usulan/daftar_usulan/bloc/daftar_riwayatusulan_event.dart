part of 'daftar_riwayatusulan_bloc.dart';

abstract class DaftarRiwayatusulanEvent extends Equatable {
  const DaftarRiwayatusulanEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailUsulanEvent extends DaftarRiwayatusulanEvent {
  final String nidn;
  final List<Usulan> usulanList;

  const FetchDetailUsulanEvent({required this.nidn, required this.usulanList});
}
