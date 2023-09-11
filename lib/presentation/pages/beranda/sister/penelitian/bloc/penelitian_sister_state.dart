part of 'penelitian_sister_bloc.dart';

abstract class PenelitianSisterState extends Equatable {
  const PenelitianSisterState();

  @override
  List<Object> get props => [];
}

class PenelitianSisterinInitial extends PenelitianSisterState {}

class PenelitianSisterLoadedState extends PenelitianSisterState {
  final List<PenelitianData> penelitianData;
  final List<Publikasi> publikasi;
  final String nidn;

  PenelitianSisterLoadedState(
      {required this.nidn,
      required this.penelitianData,
      required this.publikasi});
  @override
  List<Object> get props => [penelitianData, publikasi];
}

class PenelitianSisterNoInternetState extends PenelitianSisterState {
  final String nidn;

  PenelitianSisterNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class PenelitianSisterErrorState extends PenelitianSisterState {
  final String nidn;

  PenelitianSisterErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class PenelitianSisterNotFoundState extends PenelitianSisterState {
  final PenelitianSister? penelitianSister;

  PenelitianSisterNotFoundState(this.penelitianSister);

  @override
  List<Object> get props => [];
}
