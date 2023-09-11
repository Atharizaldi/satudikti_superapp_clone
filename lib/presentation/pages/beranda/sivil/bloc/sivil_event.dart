part of 'sivil_bloc.dart';

abstract class SivilEvent extends Equatable {
  const SivilEvent();

  @override
  List<Object> get props => [];
}

class ClearEvent extends SivilEvent {}

class UpdatePTEvent extends SivilEvent {
  final PerguruanTinggi pt;

  UpdatePTEvent({required this.pt});

  @override
  List<Object> get props => [pt];
}

class UpdateProdiEvent extends SivilEvent {
  final getListProdi.Prodi prodi;

  UpdateProdiEvent({required this.prodi});

  @override
  List<Object> get props => [prodi];
}

class UpdateNoIjazahEvent extends SivilEvent {
  final String noIjazah;

  UpdateNoIjazahEvent({required this.noIjazah});

  @override
  List<Object> get props => [noIjazah];
}
