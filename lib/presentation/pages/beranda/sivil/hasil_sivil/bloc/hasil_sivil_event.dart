part of 'hasil_sivil_bloc.dart';

abstract class HasilSivilEvent extends Equatable {
  const HasilSivilEvent();

  @override
  List<Object> get props => [];
}

class LoadHasilSivilEvent extends HasilSivilEvent {
  final String kodePT, kodeProdi, noIjazah;

  LoadHasilSivilEvent({
    required this.kodePT,
    required this.kodeProdi,
    required this.noIjazah,
  });
}
