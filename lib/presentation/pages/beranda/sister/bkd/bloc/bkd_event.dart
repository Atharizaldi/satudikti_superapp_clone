part of 'bkd_bloc.dart';

abstract class BKDSisterEvent extends Equatable {
  const BKDSisterEvent();

  @override
  List<Object> get props => [];
}

class GetBKDSisterEvent extends BKDSisterEvent {
  final String nidn;
  final String judul;
  final String sortBy;

  GetBKDSisterEvent(
      {required this.nidn, required this.judul, required this.sortBy});
}
