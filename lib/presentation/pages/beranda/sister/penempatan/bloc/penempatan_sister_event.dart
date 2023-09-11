part of 'penempatan_sister_bloc.dart';

abstract class PenempatanSisterEvent extends Equatable {
  const PenempatanSisterEvent();

  @override
  List<Object> get props => [];
}

class GetPenempatanSisterEvent extends PenempatanSisterEvent {
  final String nidn;

  GetPenempatanSisterEvent({required this.nidn}) {
    print("KESINI ==================== ${nidn}");
  }
}

// class ClassName {
  
// }
