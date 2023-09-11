part of 'biodata_sister_bloc.dart';

abstract class BiodataSisterEvent extends Equatable {
  const BiodataSisterEvent();

  @override
  List<Object> get props => [];
}

class GetBiodataSisterEvent extends BiodataSisterEvent {
  final String nidn;

  GetBiodataSisterEvent({required this.nidn});
}
