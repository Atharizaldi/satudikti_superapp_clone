part of 'sivil_bloc.dart';

abstract class SivilState extends Equatable {
  const SivilState();

  @override
  List<Object> get props => [];
}

class SivilInitialState extends SivilState {
  final PerguruanTinggi? pt;
  final getListProdi.Prodi? prodi;
  final String? noIjazah;

  SivilInitialState({ this.pt, this.prodi, this.noIjazah});

  @override
  List<Object> get props => [pt ?? '', prodi ?? '', noIjazah ?? ''];

}
