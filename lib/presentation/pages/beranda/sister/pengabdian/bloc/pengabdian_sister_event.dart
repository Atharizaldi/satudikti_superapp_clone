part of 'pengabdian_sister_bloc.dart';

abstract class PengabdianSisterEvent extends Equatable {
  const PengabdianSisterEvent();

  @override
  List<Object> get props => [];
}

class GetPengabdianSisterEvent extends PengabdianSisterEvent {
  final String nidn;

  GetPengabdianSisterEvent({required this.nidn});
}
