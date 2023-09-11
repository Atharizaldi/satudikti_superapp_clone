part of 'penelitian_sister_bloc.dart';

abstract class PenelitianSisterEvent extends Equatable {
  const PenelitianSisterEvent();

  @override
  List<Object> get props => [];
}

class GetPenelitianSisterEvent extends PenelitianSisterEvent {
  final String nidn;

  GetPenelitianSisterEvent({required this.nidn});
}
