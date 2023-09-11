part of 'garuda_paper_bloc.dart';

abstract class GarudaPaperState extends Equatable {
  const GarudaPaperState();

  @override
  List<Object> get props => [];
}

class GarudaPaperInitial extends GarudaPaperState {}

// ignore: must_be_immutable
class GarudaPaperLoaded extends GarudaPaperState {
  final GarudaPaper garudaPaperObject;
  final List<ListPaperGaruda> garudaPaper;
  bool hasReachedMax;
  final int newPage;

  GarudaPaperLoaded(
      {required this.garudaPaper,
      required this.garudaPaperObject,
      required this.hasReachedMax,
      required this.newPage});
  @override
  List<Object> get props =>
      [garudaPaper, garudaPaperObject, hasReachedMax, newPage];
}

class GarudaPaperNoInternet extends GarudaPaperState {}

class GarudaPaperNotFound extends GarudaPaperState {}

class GarudaPaperServerProblem extends GarudaPaperState {}

class GarudaPaperLoading extends GarudaPaperState {}
