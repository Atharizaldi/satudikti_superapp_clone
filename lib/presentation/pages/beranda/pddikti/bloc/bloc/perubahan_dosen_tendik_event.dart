part of 'perubahan_dosen_tendik_bloc.dart';

abstract class PerubahanDosenTendikEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPerubahanDosenTendikEvent extends PerubahanDosenTendikEvent {
  final String nidn;
  FetchPerubahanDosenTendikEvent({required this.nidn});
  @override
  List<Object> get props => [];
}
