part of 'detail_cerita_km_bloc.dart';

abstract class DetailCeritaKMState extends Equatable {
  const DetailCeritaKMState();

  @override
  List<Object> get props => [];
}

class DetailCeritaKMinInitial extends DetailCeritaKMState {}

class DetailCeritaKMinLoading extends DetailCeritaKMState {}

class DetailCeritaKMLoadedState extends DetailCeritaKMState {
  final DataDetailCerita dataDetailCerita;

  DetailCeritaKMLoadedState({required this.dataDetailCerita});

  @override
  List<Object> get props => [dataDetailCerita];
}

class DetailCeritaKMNoInternetState extends DetailCeritaKMState {
  final String id;
  DetailCeritaKMNoInternetState({required this.id});
  @override
  List<Object> get props => [this.id ];
}

class DetailCeritaKMErrorState extends DetailCeritaKMState {

}
