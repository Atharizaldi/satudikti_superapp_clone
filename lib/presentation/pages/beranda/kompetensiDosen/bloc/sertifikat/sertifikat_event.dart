part of 'sertifikat_bloc.dart';

abstract class SertifikatEvent extends Equatable {
  const SertifikatEvent();

  @override
  List<Object> get props => [];
}

class GetSertifikatEvent extends SertifikatEvent {
  final String id;
  GetSertifikatEvent({required this.id});
}
