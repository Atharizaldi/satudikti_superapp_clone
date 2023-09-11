part of 'detail_cerita_km_bloc.dart';


abstract class DetailCeritaKMEvent extends Equatable {
  const DetailCeritaKMEvent();

  @override
  List <Object> get props => [];
}

class GetDetailCeritaKMEvent extends DetailCeritaKMEvent {

  final String id;

  GetDetailCeritaKMEvent({required this.id});
  @override
  List<Object> get props => [id];
}