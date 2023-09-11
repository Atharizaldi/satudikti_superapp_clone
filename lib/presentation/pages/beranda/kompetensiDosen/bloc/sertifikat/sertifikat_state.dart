part of 'sertifikat_bloc.dart';

abstract class SertifikatState extends Equatable {
  const SertifikatState();

  @override
  List<Object> get props => [];
}

class SertifikatInitial extends SertifikatState {}

class SertifikatError extends SertifikatState {}

class SertifikatLoaded extends SertifikatState {
  final Sertifikat sertifikat;
  SertifikatLoaded({required this.sertifikat});
}
