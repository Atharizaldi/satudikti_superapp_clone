part of 'penilaian_dosen_bloc.dart';

abstract class PenilaianDosenEvent extends Equatable {
  const PenilaianDosenEvent();

  @override
  List<Object> get props => [];
}

class GetPenilaianDosenEvent extends PenilaianDosenEvent {
  final String id;
  GetPenilaianDosenEvent({required this.id});
}

class GetSertifikatEvent extends PenilaianDosenEvent {
  final String id;
  GetSertifikatEvent({required this.id});
}
